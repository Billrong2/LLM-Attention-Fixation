f <- function(text, char, replace) {    return(gsub(char, replace, text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a1a8', '1', 'n2'), 'an2a8')))
}
test_humaneval()
