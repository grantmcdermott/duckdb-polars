using DuckDB
using DataFrames
using Dates

con = DBInterface.connect(DuckDB.DB)

# https://grantmcdermott.com/duckdb-polars/duckdb-sql.html
# https://duckdb.org/docs/api/julia.html#basics
dat1 = DBInterface.execute(
  con,
  "
  FROM 'nyc-taxi/**/*.parquet'
  SELECT
    passenger_count,
    AVG(tip_amount) AS mean_tip
  GROUP BY ALL
  ORDER BY ALL
  "
)

df_long = DBInterface.execute(
  con,
  "
  WITH tmp_table AS (
    FROM 'nyc-taxi/**/*.parquet'
    SELECT
      passenger_count,
      trip_distance,
      AVG(tip_amount) AS mean_tip,
      AVG(fare_amount) AS mean_fare
    GROUP BY ALL
  )
  UNPIVOT tmp_table
  ON mean_tip, mean_fare
  INTO
    NAME variable
    VALUE amount
  "
) |> DataFrame

# read back into a duckdb

DuckDB.register_data_frame(con, df_long, "df_long")

results = DBInterface.execute(con, "SELECT * FROM df_long")


# create data to insert
ndf = 100_000
df = DataFrames.DataFrame(
        id = collect(1:ndf),
        value = rand(Float32,ndf),
        timestamp = Dates.now() + Dates.Second.(1:ndf),
        date = Dates.today() + Dates.Day.(1:ndf)
    )

db = DuckDB.DB()


# traditional way
DBInterface.execute(db,
    """
    CREATE OR REPLACE TABLE test_table1(id INTEGER PRIMARY KEY, value FLOAT, timestamp TIMESTAMP, date DATE)
    """)

stmt = DBInterface.prepare(db, 
    """
    INSERT INTO test_table1 VALUES(?,?,?,?)
    """)

@elapsed for r in eachrow(df)
    DBInterface.execute(stmt, (r.id, r.value, r.timestamp, r.date))
end

# appender way

# create a table
DBInterface.execute(db,
    "CREATE OR REPLACE TABLE test_table2(id INTEGER PRIMARY KEY, value FLOAT, timestamp TIMESTAMP, date DATE)")


# create an appender on the second table
appender = DuckDB.Appender(db, "test_table2")

@elapsed begin
    for i in eachrow(df)
        for j in i
            DuckDB.append(appender, j)
        end
    DuckDB.end_row(appender)
    end
    DuckDB.close(appender)  # done now
end

appended_df = DBInterface.execute(db, "SELECT * from data") |> DataFrame

appended_df .== df

appended_df .- df


df32 = DataFrames.DataFrame(
    id = collect(1:len),
    value = rand(Float32,len),
    timestamp = Dates.now() + Dates.Second.(1:len),
    date = Dates.today() + Dates.Day.(1:len)
)

DBInterface.execute(db,
    "CREATE OR REPLACE TABLE data32(id INTEGER PRIMARY KEY, value FLOAT, timestamp TIMESTAMP, date DATE)")

# create an appender
appender = DuckDB.Appender(db, "data32")

for i in eachrow(df32)
    for j in i
        DuckDB.append(appender, j)
    end
    DuckDB.end_row(appender)
end
DuckDB.close(appender)  # done now

# check data on db
appended_df32 = DBInterface.execute(db, "SELECT * from data32") |> DataFrame

appended_df32 .== df32




