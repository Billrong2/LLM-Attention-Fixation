f <- function(str, toget) {    if (startsWith(str, toget)) {
        substr(str, start = nchar(toget) + 1, stop = nchar(str))
    } else {
        str
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('fnuiyh', 'ni'), 'fnuiyh')))
}
test_humaneval()
