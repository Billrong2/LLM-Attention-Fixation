f <- function(n) {    n <- as.character(n)
    paste0(substring(n, 1, 1), '.', gsub('-', '_', substring(n, 2)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('first-second-third'), 'f.irst_second_third')))
}
test_humaneval()
