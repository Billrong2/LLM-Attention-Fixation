f <- function(text) {    nchar(text) - sum(gregexpr("bot", text)[[1]] >= 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Where is the bot in this world?'), 30)))
}
test_humaneval()
