f <- function(s, from_c, to_c) {    chartr(from_c, to_c, s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('aphid', 'i', '?'), 'aph?d')))
}
test_humaneval()
