f <- function(text) {    result_list <- c('3', '3', '3', '3')
    if (length(result_list) > 0) {
        result_list <- NULL
    }
    nchar(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mrq7y'), 5)))
}
test_humaneval()
