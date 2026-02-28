f <- function(char_map, text) {    new_text <- ''
    for (ch in strsplit(text, '')[[1]]) {
        val <- char_map[[ch]]
        if (is.null(val)) {
            new_text <- paste0(new_text, ch)
        } else {
            new_text <- paste0(new_text, val)
        }
    }
    return(new_text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(), 'hbd'), 'hbd')))
}
test_humaneval()
