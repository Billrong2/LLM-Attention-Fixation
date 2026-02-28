f <- function(num) {    if (0 < num & num < 1000 & num != 6174) {
        return('Half Life')
    } else {
        return('Not found')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(6173), 'Not found')))
}
test_humaneval()
