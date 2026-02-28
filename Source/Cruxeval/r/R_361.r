f <- function(text) {    split_text <- unlist(strsplit(text, ":"))
    count_char <- nchar(gsub("[^#]", "", split_text[1]))
    return(count_char)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('#! : #!'), 1)))
}
test_humaneval()
