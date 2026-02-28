f <- function(s, n) {    tolower(s) == tolower(n)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('daaX', 'daaX'), TRUE)))
}
test_humaneval()
