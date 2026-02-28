f <- function(text, to_remove) {    new_text <- unlist(strsplit(text, ''))
    if (to_remove %in% new_text) {
        index <- which(new_text == to_remove)[1]
        new_text <- new_text[new_text != to_remove]
        new_text <- append(new_text, '?', after = index - 1)
        new_text <- new_text[new_text != '?']
    }
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('sjbrlfqmw', 'l'), 'sjbrfqmw')))
}
test_humaneval()
