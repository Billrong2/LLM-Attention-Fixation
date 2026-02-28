f <- function(string) {    if (toupper(string) == string) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Ohno'), FALSE)))
}
test_humaneval()
