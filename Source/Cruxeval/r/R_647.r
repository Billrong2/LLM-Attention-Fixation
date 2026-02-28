f <- function(text, chunks) {    unlist(strsplit(text, "\n"))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('/alcm@ an)t//eprw)/e!/d\nujv', 0), c('/alcm@ an)t//eprw)/e!/d', 'ujv'))))
}
test_humaneval()
