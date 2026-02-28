f <- function(text) {    uppers <- 0
    for (c in strsplit(text, '')[[1]]) {
        if (toupper(c) == c) {
            uppers <- uppers + 1
        }
    }
    if (uppers >= 10) {
        return(toupper(text))
    } else {
        return(text)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('?XyZ'), '?XyZ')))
}
test_humaneval()
