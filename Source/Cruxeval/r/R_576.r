f <- function(array, const) {    output <- c('x')
    for (i in 1:length(array)) {
        if (i %% 2 != 0) {
            output <- c(output, as.character(array[i] * -2))
        } else {
            output <- c(output, as.character(const))
        }
    }
    return(output)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3), -1), c('x', '-2', '-1', '-6'))))
}
test_humaneval()
