f <- function(text) {    ans <- ''
    while(nchar(text) > 0) {
        split_text <- strsplit(text, '\\(', fixed=TRUE)[[1]]
        x <- split_text[1]
        sep <- '('
        text <- paste(split_text[-1], collapse='(')
        ans <- paste0(x, sep, ans)
        ans <- paste0(ans, sep, text[1], ans)
        text <- substr(text, 2, nchar(text))
    }
    return(ans)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(''), '')))
}
test_humaneval()
