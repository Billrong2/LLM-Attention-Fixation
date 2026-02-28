f <- function(match, fill, n) {    paste0(substr(fill, 1, n), match)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('9', '8', 2), '89')))
}
test_humaneval()
