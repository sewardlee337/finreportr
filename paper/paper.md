---
title: 'finreportr: Financial Data from U.S. Securities and Exchange Commission'
tags:
  - finance
  - accounting
authors:
 - name: Seward Lee
   orcid: 0000-0001-5583-035X
date: 31 October 2016
bibliography: paper.bib
---

# Summary

'finreportr' is a R package that automates the downloading and processing of XBRL documents containing financial data from the U.S. Securities and Exchange Commission's EDGAR database. Using a suite of simple functions, data from the Statement of Operations, Balance Sheet, and Statement of Cash Flow of Form 10-Ks may be downloaded, processed, and returned to the user in R dataframes.

The design of functions included in 'finreportr' is inspired by the quantitative finance package 'quantmod' (Ryan, Ulrich, and Thielsen 2016). XBRL-processing capabilities of 'finreportr' is mainly powered by the package 'XBRL' (Bertolusso and Kimmel 2016) under the hood.

# References

Bertolusso, Roberto and Marek Kimmel. 2016. *XBRL: Extraction of Business Financial Information from 'XBRL' Documents.* https://CRAN.R-project.org/package=XBRL.

Ryan, Jeffrey A., Joshua M. Ulrich, and Wouter Thielen. 2016. *quantmod: Quantitative Financial Modelling Framework.* https://CRAN.R-project.org/package=quantmod.