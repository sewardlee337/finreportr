#' Acquire income statement.
#' 
#' Extracts and displays income statement from the annual report of a given company.
#' This functionality is only available for queries of income statements that belong to domestic companies.
#' Note that all data returned by this function comes from the company's 10-K, not 10-K/A.
#' 
#' @export
#' @param symbol A character vector specifying the stock symbol of the company of interest.
#' @param year A numeric vector specifying the year during which the annual report was filed.
#' @examples 
#' \dontrun{
#' GetIncome("FB", 2016)
#' }


GetIncome <- function(symbol, year) {
     
     income.descriptions <- c("CONSOLIDATED STATEMENTS OF INCOME", 
                              "CONSOLIDATED STATEMENT OF INCOME", 
                              "CONSOLIDATED STATEMENTS OF OPERATIONS", 
                              "CONSOLIDATED STATEMENT OF OPERATIONS", 
                              "CONSOLIDATED STATEMENT OF EARNINGS", 
                              "CONSOLIDATED STATEMENTS OF EARNINGS",
                              "INCOME STATEMENTS", 
                              "CONSOLIDATED RESULTS OF OPERATIONS")
     
     GetFinancial(income.descriptions, symbol, year)
}