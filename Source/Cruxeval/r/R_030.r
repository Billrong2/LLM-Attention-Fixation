f <- function(array) {    result <- c()
    for (elem in array) {
        if (grepl("[ -~]", elem, perl = TRUE) || (is.numeric(elem) && !grepl("[ -~]", abs(elem), perl = TRUE))) {
            result <- c(result, elem)
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('a', 'b', 'c')), c('a', 'b', 'c'))))
}
test_humaneval()
