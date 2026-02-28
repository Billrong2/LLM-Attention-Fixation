f <- function(text, size) {
    counter <- nchar(text)
    for (i in 1:(size-size%%2)) {
        text <- paste0(' ', text, ' ')
        counter <- counter + 2
        if (counter >= size) {
            return(text)
        }
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('7', 10), '     7     ')))
}
test_humaneval()
