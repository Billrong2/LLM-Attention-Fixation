f <- function(text) {    i <- (nchar(text) + 1) %/% 2
    result <- unlist(strsplit(text, ''))
    while (i < nchar(text)) {
        t <- tolower(result[i + 1])
        if (t == result[i + 1]) {
            i <- i + 1
        } else {
            result[i + 1] <- t
        }
        i <- i + 2
    }
    paste(result, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mJkLbn'), 'mJklbn')))
}
test_humaneval()
