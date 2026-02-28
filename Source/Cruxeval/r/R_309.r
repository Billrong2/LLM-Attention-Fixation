f <- function(text, suffix) {    text <- paste0(text, suffix)
    while(substr(text, nchar(text) - nchar(suffix) + 1, nchar(text)) == suffix) {
        text <- substr(text, 1, nchar(text) - 1)
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('faqo osax f', 'f'), 'faqo osax ')))
}
test_humaneval()
