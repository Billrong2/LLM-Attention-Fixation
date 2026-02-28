f <- function(string, prefix) {    if (startsWith(string, prefix)) {
        substring(string, first = nchar(prefix) + 1)
    } else {
        string
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Vipra', 'via'), 'Vipra')))
}
test_humaneval()
