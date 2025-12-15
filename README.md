[![CC BY 4.0][cc-by-shield]][cc-by]

# (Pretty) big data wrangling with DuckDB and Polars

_Note: These materials were originally prepared as part of the
[Workshops for Ukraine](https://sites.google.com/view/dariia-mykhailyshyna/main/r-workshops-for-ukraine#h.xc2x33lbfxln)
series. I have since refined and reused them in other contexts_

**Website:** https://grantmcdermott.com/duckdb-polars

**Description:** This workshop will introduce you to [DuckDB](https://duckdb.org/) and
[Polars](https://github.com/pola-rs/polars), two data wrangling libraries at the
frontier of high-performance computation. (See
[benchmarks](https://duckdblabs.github.io/db-benchmark/).) In addition to being
extremely fast and portable, both DuckDB and Polars provide user-friendly
implementations across multiple languages. This makes them very well suited to
production and applied research settings, without the overhead of tools like
Spark. We will provide a variety of real-life examples in both R and Python,
with the aim of getting participants up and running as quickly as possible. We
will learn how wrangle datasets extending over several hundred million
observations in a matter of seconds or less, using only our laptops. And we will
learn how to scale to even larger contexts where the data exceeds our computers’
RAM capacity. Finally, we will also discuss some complementary tools and how
these can be integrated for an efficient end-to-end workflow (data I/O ->
wrangling -> analysis).

_Disclaimer: The content for this workshop has been prepared, and is presented,
in my personal capacity. Any opinions expressed herein are my own and are not
necessarily shared by my employer. Please do not share any recorded material
(e.g., audio or video) without the express permission of myself or the workshop
organisers. The materials themselves may be freely repurposed and distributed
(with attribution) per the accompanying CC BY 4.0._

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
