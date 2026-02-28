f <- function(text) {    length(strsplit(text, "\n")[[1]])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ncdsdfdaaa0a1cdscsk*XFd'), 1)))
}
test_humaneval()
