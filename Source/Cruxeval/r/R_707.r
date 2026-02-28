f <- function(text, position) {    length <- nchar(text)
    index <- position %% (length + 1)
    if (position < 0 || index < 0) {
        index <- -1
    }
    new_text <- strsplit(text, '')[[1]]
    new_text <- new_text[-(index + 1)]
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('undbs l', 1), 'udbs l')))
}
test_humaneval()
