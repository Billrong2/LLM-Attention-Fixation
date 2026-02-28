f <- function(matrix) {    matrix <- rev(matrix)
    result <- list()
    for (primary in matrix) {
        primary <- sort(primary, decreasing = TRUE)
        result <- c(result, list(primary))
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c(1, 1, 1, 1))), list(c(1, 1, 1, 1)))))
}
test_humaneval()
