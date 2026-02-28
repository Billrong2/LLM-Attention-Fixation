f <- function(text, tabstop) {    text <- gsub('\n', '_____', text)
    text <- gsub('\t', paste(rep(' ', tabstop), collapse = ''), text)
    text <- gsub('_____', '\n', text)
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('odes\tcode\twell', 2), 'odes  code  well')))
}
test_humaneval()
