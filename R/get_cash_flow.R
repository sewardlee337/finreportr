#' Acquire statement of cash flow.
#' 
#' Extracts and displays statement of cash flow from the annual report of a given company. 
#' This functionality is only available for queries of cash flow statements that belong to domestic company. 
#' Note that all data returned by this function comes from the company's Form 10-K, not Form 10-K/A.
#' 
#' @export
#' @param symbol A character vector specifying the stock symbol of the company of interest.
#' @param year A numeric vector specifying the year during which the annual report was filed.
#' @examples 
#' \dontrun{
#' GetCashFlow("FB", 2016)
#' }


GetCashFlow <- function(symbol, year) {
     
     cash.flow.descriptions <- c("CONSOLIDATED STATEMENT OF CASH FLOWS", 
                                 "CONSOLIDATED STATEMENTS OF CASH FLOWS",
                                 "CASH FLOWS STATEMENTS",
                                 "CONSOLIDATED STATEMENT OF CASH FLOW")
     
     GetFinancial(cash.flow.descriptions, symbol, year)
     
}