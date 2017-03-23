[![Travis-CI Build Status](https://travis-ci.org/sewardlee337/finreportr.svg?branch=master)](https://travis-ci.org/sewardlee337/finreportr) [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/finreportr)](https://cran.r-project.org/package=finreportr) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.192466.svg)](https://doi.org/10.5281/zenodo.192466)
[![status](http://joss.theoj.org/papers/128c974cac2dcf92b673c66f39a2c93e/status.svg)](http://joss.theoj.org/papers/128c974cac2dcf92b673c66f39a2c93e) [![Rdoc](http://www.rdocumentation.org/badges/version/finreportr)](http://www.rdocumentation.org/packages/finreportr)

# finreportr - Financial Data from U.S. Securities and Exchange Commission

* Author/Maintainer: [Seward Lee](https://github.com/sewardlee337)
* License: [MIT](https://opensource.org/licenses/MIT)

## Introduction

A financial analyst's time is valuable – it shouldn't be wasted performing manual data entry. finreportr is a web scraper written in R that allows analysts to query data from the U.S. Securities and Exchange Commission directly from the R console.  It aims to eliminate time wasters from a financial analyst's workflow, such as navigating the SEC EDGAR database, flipping through financial reports, and parsing XBRL-encoded data.

finreportr allows you to fetch data from the SEC and load it into your workspace using the following commands:
* `CompanyInfo()`: returns basic information about a company
* `AnnualReports()`: returns a listing of annual reports filed by a company
* `GetIncome()`: returns the income statement for a given company
* `GetBalanceSheet()`: returns the balance sheet for a given company
* `GetCashFlow()`: returns the cash flow statement for a given company

To install CRAN release version of finreportr:

```
install.packages("finreportr")
```

To install bleeding-edge version from GitHub:

```
devtools::install_github("sewardlee337/finreportr")
```

## CompanyInfo()

`CompanyInfo()` returns the following information about a given company based on its stock ticker symbol:
* Company Name
* [Central Index Key ("CIK")](https://en.wikipedia.org/wiki/Central_Index_Key)
* [Standard  Industrial Classification ("SIC")](https://en.wikipedia.org/wiki/Standard_Industrial_Classification)
* State Location
* State of Incorporation
* Fiscal Year End (ddmm)
* Street Address
* City, State, ZIP

#### Arguments:

`CompanyInfo(symbol)`

where

* `symbol` is a character string that represents the relevant stock ticker symbol.

#### Examples:

```
> CompanyInfo("GOOG")

      company        CIK  SIC state state.inc FY.end            street.address             city.state
1 GOOGLE INC. 0001288776 7370    CA        DE   1231 1600 AMPHITHEATRE PARKWAY MOUNTAIN VIEW CA 94043


> CompanyInfo("FB")

       company        CIK  SIC state state.inc FY.end   street.address          city.state
1 Facebook Inc 0001326801 7370    CA        DE   1231 1601 WILLOW ROAD MENLO PARK CA 94025
```


## AnnualReports()

`AnnualReports()` returns a dataframe that summarizes a given company's annual reports based on its stock ticker symbol. Information returned include:
* Filing Name
* Filing Date
* [Accession Number](https://www.sec.gov/investor/pubs/edgarguide.htm#P158_19972)

`AnnualReports()` will return data relating to a company's [Form 10-Ks](http://www.investopedia.com/terms/1/10-k.asp) if the company is domestic, and [Form 20-Fs](http://www.investopedia.com/terms/s/sec-form-20-f.asp) if the company is foreign. 

#### Arguments:

`AnnualReports(symbol, foreign = FALSE)`

where

* `symbol` is a character string that represents the relevant stock ticker symbol.
* `foreign` is a logical indicating whether the company in question is domestic or foreign.  `foreign` is set to `FALSE` by default.

#### Examples:

```
> AnnualReports("GOOG")

   filing.name filing.date         accession.no
1         10-K  2015-02-09 0001288776-15-000008
2         10-K  2014-02-12 0001288776-14-000020
3         10-K  2013-01-29 0001193125-13-028362
4       10-K/A  2012-04-23 0001193125-12-174477
5         10-K  2012-01-26 0001193125-12-025336
6         10-K  2011-02-11 0001193125-11-032930
7         10-K  2010-02-12 0001193125-10-030774
8         10-K  2009-02-13 0001193125-09-029448
9         10-K  2008-02-15 0001193125-08-032690
10        10-K  2007-03-01 0001193125-07-044494
11        10-K  2006-03-16 0001193125-06-056598
12        10-K  2005-03-30 0001193125-05-065298


> AnnualReports("HTHIY", foreign = TRUE)

   filing.name filing.date         accession.no
1       20-F/A  2011-07-21 0001193125-11-192990
2         20-F  2011-06-24 0001193125-11-172867
3       20-F/A  2010-07-29 0001193125-10-169851
4         20-F  2010-06-29 0001193125-10-149406
5         20-F  2009-07-27 0001193125-09-155317
6         20-F  2008-06-20 0001193125-08-137042
7       20-F/A  2008-04-28 0001193125-08-091853
8       20-F/A  2007-11-30 0001193125-07-256746
9         20-F  2007-06-26 0001193125-07-142357
10        20-F  2006-08-07 0001193125-06-163031
11        20-F  2005-08-26 0001193125-05-174960
12        20-F  2004-08-20 0001193125-04-144223
13        20-F  2003-09-30 0001193125-03-056135
14        20-F  2002-09-26 0001145549-02-000252
```

## GetIncome()

`GetIncome()` returns a company's income statement from the annual report of a given filing year as a dataframe.  This functionality is only available for queries of income statements that belong to domestic companies.  Note that all data returned by this function comes from the company's 10-K, not 10-K/A.

#### Arguments:

`GetIncome(symbol, year)`

where

* `symbol` is a character string that represents the relevant stock ticker symbol.
* `year` is the year during which the annual report was filed. *(Note: This is not necessarily identical to the fiscal year for which the annual report was filed)*

#### Example:

```
###   Fetch first 20 lines of Google's income statement in the Form 10-K published in 2016.

> head(GetIncome("GOOG", 2016), 20)

                               Metric Units      Amount  startDate    endDate
1                            Revenues   usd 55519000000 2013-01-01 2013-12-31
2                            Revenues   usd 66001000000 2014-01-01 2014-12-31
3                            Revenues   usd 74989000000 2015-01-01 2015-12-31
4                     Cost of Revenue   usd 21993000000 2013-01-01 2013-12-31
5                     Cost of Revenue   usd 25691000000 2014-01-01 2014-12-31
6                     Cost of Revenue   usd 28164000000 2015-01-01 2015-12-31
7    Research and Development Expense   usd  7137000000 2013-01-01 2013-12-31
8    Research and Development Expense   usd  9832000000 2014-01-01 2014-12-31
9    Research and Development Expense   usd 12282000000 2015-01-01 2015-12-31
10      Selling and Marketing Expense   usd  6554000000 2013-01-01 2013-12-31
11      Selling and Marketing Expense   usd  8131000000 2014-01-01 2014-12-31
12      Selling and Marketing Expense   usd  9047000000 2015-01-01 2015-12-31
13 General and Administrative Expense   usd  4432000000 2013-01-01 2013-12-31
14 General and Administrative Expense   usd  5851000000 2014-01-01 2014-12-31
15 General and Administrative Expense   usd  6136000000 2015-01-01 2015-12-31
16                 Costs and Expenses   usd 40116000000 2013-01-01 2013-12-31
17                 Costs and Expenses   usd 49505000000 2014-01-01 2014-12-31
18                 Costs and Expenses   usd 55629000000 2015-01-01 2015-12-31
19            Operating Income (Loss)   usd 15403000000 2013-01-01 2013-12-31
20            Operating Income (Loss)   usd 16496000000 2014-01-01 2014-12-31
```

## GetBalanceSheet()

`GetBalanceSheet()` returns a company's balance sheet from the annual report of a given filing year as a dataframe. This functionality is only available for queries of balance sheets that belong to domestic companies.  Note that all data returned by this function comes from the company's 10-K, not 10-K/A.

#### Arguments:

`GetBalanceSheet(symbol, year)`

where

* `symbol` is a character string that represents the relevant stock ticker symbol.
* `year` is the year during which the annual report was filed. *(Note: This is not necessarily identical to the fiscal year for which the annual report was filed)*

#### Example:

```
###   Fetch first 20 lines of Google's balance sheet in the Form 10-K published in 2016.

> head(GetBalanceSheet("GOOG", 2016), 20)

                                                       Metric Units      Amount startDate    endDate
1                Cash and Cash Equivalents, at Carrying Value   usd 14778000000      <NA> 2012-12-31
2                Cash and Cash Equivalents, at Carrying Value   usd 18898000000      <NA> 2013-12-31
3                Cash and Cash Equivalents, at Carrying Value   usd 18347000000      <NA> 2014-12-31
4                Cash and Cash Equivalents, at Carrying Value   usd 16549000000      <NA> 2015-12-31
5                      Available-for-sale Securities, Current   usd 46048000000      <NA> 2014-12-31
6                      Available-for-sale Securities, Current   usd 56517000000      <NA> 2015-12-31
7          Cash, Cash Equivalents, and Short-term Investments   usd 64395000000      <NA> 2014-12-31
8          Cash, Cash Equivalents, and Short-term Investments   usd 73066000000      <NA> 2015-12-31
9                           Accounts Receivable, Net, Current   usd  9383000000      <NA> 2014-12-31
10                          Accounts Receivable, Net, Current   usd 11556000000      <NA> 2015-12-31
11             Receivable Under Reverse Repurchase Agreements   usd   875000000      <NA> 2014-12-31
12             Receivable Under Reverse Repurchase Agreements   usd   450000000      <NA> 2015-12-31
13                           Income Taxes Receivable, Current   usd   591000000      <NA> 2014-12-31
14                           Income Taxes Receivable, Current   usd  1903000000      <NA> 2015-12-31
15    Prepaid Revenue Share Expenses And Other Assets Current   usd  3412000000      <NA> 2014-12-31
16    Prepaid Revenue Share Expenses And Other Assets Current   usd  3139000000      <NA> 2015-12-31
17                                            Assets, Current   usd 78656000000      <NA> 2014-12-31
18                                            Assets, Current   usd 90114000000      <NA> 2015-12-31
19 Prepaid Revenue Share Expenses And Other Assets Noncurrent   usd  3187000000      <NA> 2014-12-31
20 Prepaid Revenue Share Expenses And Other Assets Noncurrent   usd  3181000000      <NA> 2015-12-31
```

## GetCashFlow()

`GetCashFlow()` returns a company's statement of cash flow from the annual report of a given filing year as a dataframe. This functionality is only available for queries of cash flow statements that belong to domestic companies.  Note that all data returned by this function comes from the company's 10-K, not 10-K/A.

#### Arguments:

`GetCashFlow(symbol, year)`

where

* `symbol` is a character string that represents the relevant stock ticker symbol.
* `year` is the year during which the annual report was filed. *(Note: This is not necessarily identical to the fiscal year for which the annual report was filed)*

#### Example:

```
###   Fetch first 20 lines of Google's cash flow statement in the Form 10-K published in 2016.

> head(GetCashFlow("GOOG", 2016), 20)

                                                                   Metric Units      Amount  startDate    endDate
1                                Net Income (Loss) Attributable to Parent   usd 12733000000 2013-01-01 2013-12-31
2                                Net Income (Loss) Attributable to Parent   usd 14136000000 2014-01-01 2014-12-31
3                                Net Income (Loss) Attributable to Parent   usd 16348000000 2015-01-01 2015-12-31
4    Depreciation and Impairment on Disposition of Property and Equipment   usd  2781000000 2013-01-01 2013-12-31
5    Depreciation and Impairment on Disposition of Property and Equipment   usd  3523000000 2014-01-01 2014-12-31
6    Depreciation and Impairment on Disposition of Property and Equipment   usd  4132000000 2015-01-01 2015-12-31
7              Amortization and Impairment of Intangible and Other Assets   usd  1158000000 2013-01-01 2013-12-31
8              Amortization and Impairment of Intangible and Other Assets   usd  1456000000 2014-01-01 2014-12-31
9              Amortization and Impairment of Intangible and Other Assets   usd   931000000 2015-01-01 2015-12-31
10                                               Share-based Compensation   usd  3343000000 2013-01-01 2013-12-31
11                                               Share-based Compensation   usd  4279000000 2014-01-01 2014-12-31
12                                               Share-based Compensation   usd  5203000000 2015-01-01 2015-12-31
13 Excess Tax Benefit from Share-based Compensation, Operating Activities   usd   481000000 2013-01-01 2013-12-31
14 Excess Tax Benefit from Share-based Compensation, Operating Activities   usd   648000000 2014-01-01 2014-12-31
15 Excess Tax Benefit from Share-based Compensation, Operating Activities   usd   548000000 2015-01-01 2015-12-31
16                                  Deferred Income Taxes and Tax Credits   usd  -437000000 2013-01-01 2013-12-31
17                                  Deferred Income Taxes and Tax Credits   usd  -104000000 2014-01-01 2014-12-31
18                                  Deferred Income Taxes and Tax Credits   usd  -179000000 2015-01-01 2015-12-31
19     Gain (Loss) on Sale of Business, Including Discontinued Operations   usd   700000000 2013-01-01 2013-12-31
20     Gain (Loss) on Sale of Business, Including Discontinued Operations   usd   740000000 2014-01-01 2014-12-31
```

## Bug Reports and Feedback

Please use the GitHub issue tracker for bug reports, feature request, or general discussions.
