f <- function(text, tab_size) {    text <- gsub('\t', paste(rep(' ', tab_size-1), collapse=''), text)
    res <- ''
    for (i in 1:nchar(text)) {
        if (substr(text, i, i) == ' ') {
            res <- paste0(res, '|')
        } else {
            res <- paste0(res, substr(text, i, i))
        }
    }
    return(res)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('\ta', 3), '||a')))
}
test_humaneval()
