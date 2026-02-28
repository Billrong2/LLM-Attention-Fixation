f <- function(text) {    all(charToRaw(text) <= as.raw(127))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct'), FALSE)))
}
test_humaneval()
