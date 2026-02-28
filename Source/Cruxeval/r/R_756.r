f <- function(text) {    if (grepl("^[0-9]+$", text)) {
        return('integer')
    } else {
        return('string')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(''), 'string')))
}
test_humaneval()
