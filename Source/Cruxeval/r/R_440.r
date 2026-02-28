f <- function(text) {    if (grepl("^\\d+$", text)) {
        return('yes')
    } else {
        return('no')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abc'), 'no')))
}
test_humaneval()
