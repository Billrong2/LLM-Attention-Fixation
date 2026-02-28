f <- function(text, old, new) {
    if (nchar(old) > 3) {
        return(text)
    }
    if (grepl(old, text) & !grepl(' ', text)) {
        return(gsub(old, paste(rep(new, nchar(old)), collapse = ''), text))
    }
    while (grepl(old, text)) {
        text <- gsub(old, new, text)
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('avacado', 'va', '-'), 'a--cado')))
}
test_humaneval()
