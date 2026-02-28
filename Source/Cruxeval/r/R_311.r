f <- function(text) {    text <- gsub('#', '1', text)
    text <- gsub('$', '5', text)
    
    if (grepl('^[0-9]+$', text)) {
        return('yes')
    } else {
        return('no')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('A'), 'no')))
}
test_humaneval()
