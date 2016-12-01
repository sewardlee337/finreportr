#' @import dplyr

################################################################################
#####     Backend Utility: Extract Accession No                            #####
################################################################################


GetAccessionNo <- function(symbol, year, foreign = FALSE) {
     
     ##   This is here to please R CMD check
     filing.year <- NULL
     filing.name <- NULL
     accession.no <- NULL
     
     year.char <- as.character(year)
     
     reports.df <- AnnualReports(symbol, foreign)
     reports.df <-
          mutate(reports.df, filing.year = substr(reports.df$filing.date,1,4) ) %>%
          filter(filing.year == year.char) %>%
          filter(filing.name == "10-K" | filing.name == "20-F")
     
     accession.no.raw <-
          select(reports.df, accession.no) %>%
          as.character()
     
     ##   Error message for function
     if(accession.no.raw == "character(0)") {
          stop("no filings available for given year")
     }
     
     return(accession.no.raw)
}

################################################################################
#####     Backend Utility: Extract Period of Report                        #####
################################################################################


ReportPeriod <- function(symbol, CIK, accession.no, accession.no.raw) {
     
     url <- paste0("https://www.sec.gov/Archives/edgar/data/", CIK, "/", 
                   accession.no, "/", accession.no.raw, "-index.htm")
     search.result <- xml2::read_html(url)
     
     ##   Generic function to extract info
     ExtractInfo <- function(html.node) {
          info <-
               search.result %>%
               rvest::html_nodes(html.node) %>%
               rvest::html_text()
          return(info)
     }
     
     report.period <- ExtractInfo(".formGrouping+ .formGrouping .info:nth-child(2)")
     return(report.period)
}