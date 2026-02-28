f <- function(text, ch) {    sum(unlist(strsplit(text, split = "")) == ch)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate("This be Pirate's Speak for 'help'!", ' '), 5)))
}
test_humaneval()
