f <- function(haystack, needle) {    index <- max(regexpr(needle, haystack), 0)
    if (index > 0 && substr(haystack, index, nchar(haystack)) == needle) {
        return(index)
    } else {
        return(-1)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('345gerghjehg', '345'), -1)))
}
test_humaneval()
