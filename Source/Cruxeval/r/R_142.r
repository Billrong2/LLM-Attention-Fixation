f <- function(x) {    if (tolower(x) == x) {
        return(x)
    } else {
        return(strrev(x))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ykdfhp'), 'ykdfhp')))
}
test_humaneval()
