f <- function(text) {    text <- tolower(text)
    head <- substr(text, 1, 1)
    tail <- substr(text, 2, nchar(text))
    paste(toupper(head), tail, sep = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Manolo'), 'Manolo')))
}
test_humaneval()
