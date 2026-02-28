f <- function(text) {
  paste0(text, rep("#", nchar(text) + 1 - nchar(text)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('the cow goes moo'), 'the cow goes moo#')))
}
test_humaneval()
