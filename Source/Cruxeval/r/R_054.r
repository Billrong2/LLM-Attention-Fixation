f <- function(text, s, e) {    sublist <- substr(text, s + 1, e)
    if (nchar(sublist) == 0) {
        return(-1)
    }
    return(which.min(utf8ToInt(sublist)) - 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('happy', 0, 3), 1)))
}
test_humaneval()
