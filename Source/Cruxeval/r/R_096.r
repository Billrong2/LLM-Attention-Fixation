f <- function(text) {    !any(sapply(strsplit(text, '')[[1]], function(c) {toupper(c) == c}))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('lunabotics'), TRUE)))
}
test_humaneval()
