f <- function(text, chars) {    chars <- unlist(strsplit(chars, ''))
    text <- unlist(strsplit(text, ''))
    new_text <- text
    while(length(new_text) > 0 && length(text) > 0) {
        if (new_text[1] %in% chars) {
            new_text <- new_text[-1]
        } else {
            break
        }
    }
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('asfdellos', 'Ta'), 'sfdellos')))
}
test_humaneval()
