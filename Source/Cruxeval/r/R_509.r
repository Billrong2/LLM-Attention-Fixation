f <- function(value, width) {    if (value >= 0) {
        paste0(strrep("0", width-nchar(value)), value)
    } else {
        paste0('-', strrep("0", width-nchar(abs(value))), abs(value))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(5, 1), '5')))
}
test_humaneval()
