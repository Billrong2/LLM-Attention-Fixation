f <- function(array) {
    if (length(array) == 1) {
        return(paste(array, collapse = ''))
    }
    result <- array
    i <- 1
    while (i < length(array)) {
        for (j in 1:2) {
            result[2*(i-1)+1] <- array[i]
            i <- i + 1
        }
    }
    return(paste(result, collapse = ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('ac8', 'qk6', '9wg')), 'ac8qk6qk6')))
}
test_humaneval()
