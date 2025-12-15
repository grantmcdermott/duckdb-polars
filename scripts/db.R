library(DBI)
library(duckdb)
library(tibble)
con = DBI::dbConnect(duckdb::duckdb(), shutdown = TRUE)  # will get erased after shutdown
# con = DBI::dbConnect(duckdb::duckdb(), dbdir = "db.duck") # would save on disk


dbWriteTable(con, "mpg", ggplot2::mpg)
dbWriteTable(con, "diamonds", ggplot2::diamonds)

dbListTables(con)

con |>
    dbReadTable("mpg") |>
    as_tibble()


sql_query = "SELECT carat, cut, clarity, color, price 
  FROM diamonds 
  WHERE price > 15000"


con |>
    dbGetQuery(sql_query) |>
    as_tibble()

sql_query = "SELECT carat, cut, clarity, color, price 
  FROM diamonds 
  WHERE price > 15000
  LIMIT 5
  "

  