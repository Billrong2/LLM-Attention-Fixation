f <- function(text) {    if (grepl("^[\\x00-\\x7F]*$", text)) {
        return('ascii')
    } else {
        return('non ascii')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('<<<<'), 'ascii')))
}
test_humaneval()
