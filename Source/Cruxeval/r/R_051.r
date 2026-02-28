f <- function(num) {    s <- strrep('<', 10)
    if (num %% 2 == 0) {
        return(s)
    } else {
        return(num - 1)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(21), 20)))
}
test_humaneval()
