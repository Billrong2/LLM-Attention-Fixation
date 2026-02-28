f <- function(text) {    result <- ''
    i <- nchar(text)
    while (i >= 1) {
        c <- substr(text, i, i)
        if (grepl("[A-Za-z]", c)) {
            result <- paste0(result, c)
        }
        i <- i - 1
    }
    result
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('102x0zoq'), 'qozx')))
}
test_humaneval()
