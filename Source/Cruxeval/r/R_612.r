f <- function(d) {    as.list(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'a'" = 42, "'b'" = 1337, "'c'" = -1, "'d'" = 5)), list("'a'" = 42, "'b'" = 1337, "'c'" = -1, "'d'" = 5))))
}
test_humaneval()
