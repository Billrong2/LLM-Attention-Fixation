f <- function(text, char) {    index <- max(regexpr(char, text))
    result <- strsplit(text, '')[[1]]
    while (index > 1) {
        result[index] <- result[index - 1]
        result[index - 1] <- char
        index <- index - 2
    }
    paste(result, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qpfi jzm', 'j'), 'jqjfj zm')))
}
test_humaneval()
