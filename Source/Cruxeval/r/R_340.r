f <- function(text) {    uppercase_index <- regexpr('A', text)
    if (uppercase_index >= 0) {
        return(paste0(substr(text, 1, uppercase_index - 1), substr(text, regexpr('a', text) + 2)))
    } else {
        return(paste(sort(strsplit(text, '')[[1]]), collapse = ''))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('E jIkx HtDpV G'), '   DEGHIVjkptx')))
}
test_humaneval()
