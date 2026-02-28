f <- function(text) {    length <- nchar(text)
    half <- length %/% 2
    encode <- charToRaw(substr(text, 1, half))
    if (substr(text, half+1, nchar(text)) == rawToChar(encode)) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('bbbbr'), FALSE)))
}
test_humaneval()
