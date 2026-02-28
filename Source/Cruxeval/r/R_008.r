f <- function(string, encryption) {    if (encryption == 0) {
        return(string)
    } else {
        return(chartr('A-Ma-mN-Zn-z', 'N-Zn-zA-Ma-m', toupper(string)))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('UppEr', 0), 'UppEr')))
}
test_humaneval()
