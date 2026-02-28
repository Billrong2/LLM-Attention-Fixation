f <- function(string) {    if (toupper(string) == string) {
        return(tolower(string))
    } else if (tolower(string) == string) {
        return(toupper(string))
    } else {
        return(string)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('cA'), 'cA')))
}
test_humaneval()
