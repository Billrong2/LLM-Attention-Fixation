f <- function(lst) {    lst <- list()
    for (i in lst) {
        if (i == 3) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 0)), TRUE)))
}
test_humaneval()
