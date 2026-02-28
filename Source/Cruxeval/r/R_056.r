f <- function(sentence) {
    all(iconv(sentence, to="ASCII") == sentence)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('1z1z1'), TRUE)))
}
test_humaneval()
