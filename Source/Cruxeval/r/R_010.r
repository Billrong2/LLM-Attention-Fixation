f <- function(text) {    new_text <- ''
    text <- tolower(trimws(text))
    for (ch in strsplit(text, '')[[1]]) {
        if (grepl('[0-9]', ch) || ch %in% c('Ä', 'ä', 'Ï', 'ï', 'Ö', 'ö', 'Ü', 'ü')) {
            new_text <- paste0(new_text, ch)
        }
    }
    return(new_text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(''), '')))
}
test_humaneval()
