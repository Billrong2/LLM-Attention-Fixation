f <- function(text, tab_size) {    gsub('\t', paste(rep(' ', tab_size), collapse=''), text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a', 100), 'a')))
}
test_humaneval()
