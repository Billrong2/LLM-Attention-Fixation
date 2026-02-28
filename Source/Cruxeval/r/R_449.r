f <- function(x) {    n <- nchar(x)
    i <- 1
    while (i <= n && grepl("^\\d$", substr(x, i, i))) {
        i <- i + 1
    }
    return(i == n + 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('1'), TRUE)))
}
test_humaneval()
