f <- function(s) {    gsub('a', '', gsub('r', '', s))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('rpaar'), 'p')))
}
test_humaneval()
