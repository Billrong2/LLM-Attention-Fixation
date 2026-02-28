f <- function(test_str) {    s <- gsub('a', 'A', test_str)
    gsub('e', 'A', s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('papera'), 'pApArA')))
}
test_humaneval()
