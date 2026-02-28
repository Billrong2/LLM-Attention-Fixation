f <- function(text, char) {   
    if (nchar(text) > 0) {
        text <- gsub(paste0('^', char), '', text)
        text <- gsub(paste0('^', substr(text, nchar(text), nchar(text))), '', text)
        text <- paste0(substr(text, 1, nchar(text) - 1), toupper(substr(text, nchar(text), nchar(text))))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('querist', 'u'), 'querisT')))
}
test_humaneval()
