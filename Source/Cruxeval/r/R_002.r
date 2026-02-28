f <- function(text) {    new_text <- strsplit(text, '')[[1]]
    new_text <- new_text[new_text != '+']
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hbtofdeiequ'), 'hbtofdeiequ')))
}
test_humaneval()
