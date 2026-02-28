f <- function(text, search) {    startsWith(search, text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('123', '123eenhas0'), TRUE)))
}
test_humaneval()
