#' Acquire balance sheet.
#' 
#' Extracts and displays balance sheet from the annual report of a given company. 
#' This functionality is only available for queries fo balance sheets that belong to domestic companies. 
#' Note that all data returned by this function comes from the company's Form 10-K, not Form 10-K/A.
#' 
#' @export
#' @param symbol A character vector specifying the stock symbol of the company of interest.
#' @param year A numeric vector specifying the year during which the annual report was filed.
#' @examples 
#' \dontrun{
#' GetBalanceSheet("FB", 2016)
#' }

GetBalanceSheet <- function(symbol, year) {
     
     balance.sheet.descriptions <- c("CONSOLIDATED BALANCE SHEET", 
                                     "CONSOLIDATED BALANCE SHEETS", 
                                     "CONSOLIDATED STATEMENT OF FINANCIAL POSITION", 
                                     "CONSOLIDATED STATEMENTS OF FINANCIAL POSITION",
                                     "BALANCE SHEETS",
                                     "CONSOLIDATED FINANCIAL POSITION")
     
     GetFinancial(balance.sheet.descriptions, symbol, year)
}

