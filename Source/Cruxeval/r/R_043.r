f <- function(n) {    if (grepl("\\D", as.character(n))) {
        n <- -1
    }
    return(n)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('6 ** 2'), -1)))
}
test_humaneval()
