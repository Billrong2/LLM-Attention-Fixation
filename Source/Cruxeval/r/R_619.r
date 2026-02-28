f <- function(title) {    tolower(title)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('   Rock   Paper   SCISSORS  '), '   rock   paper   scissors  ')))
}
test_humaneval()
