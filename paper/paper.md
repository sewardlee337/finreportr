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

'finreportr' is an R package [@R-base] that contributes to empirical finance research by automating the download of data relating to the health and transactions of publicly-listed companies, thus simplifying the workflow of financial analysts. It downloads and processes XBRL documents containing financial data from the U.S. Securities and Exchange Commission's EDGAR database. Using a suite of simple functions, data from the Statement of Operations, Balance Sheet, and Statement of Cash Flow of Form 10-Ks may be downloaded, processed, and returned to the user in R dataframes.

The design of functions included in 'finreportr' is inspired by the quantitative finance package 'quantmod' [@R-quantmod]. XBRL-processing capabilities of 'finreportr' are mainly powered by the package 'XBRL' [@R-XBRL] under the hood.

# References
