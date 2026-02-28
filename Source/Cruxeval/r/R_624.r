f <- function(text, char) {    char_index <- regexpr(char, text)
    result <- character()
    if (char_index > 0) {
        result <- strsplit(text, '')[[1]][1:(char_index-1)]
    }
    result <- c(result, strsplit(char, '')[[1]], strsplit(text, '')[[1]][(char_index + nchar(char)):nchar(text)])
    paste(result, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('llomnrpc', 'x'), 'xllomnrpc')))
}
test_humaneval()
