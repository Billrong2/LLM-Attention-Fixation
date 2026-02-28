f <- function(text, char) {    position <- nchar(text)
    if (grepl(char, text)) {
        position <- regexpr(char, text)[1] - 1
        if (position > 0) {
            position <- (position + 1) %% nchar(text)
        }
    }
    return(position)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wduhzxlfk', 'w'), 0)))
}
test_humaneval()
