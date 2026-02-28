f <- function(forest, animal) {    index <- which(strsplit(forest, '')[[1]] == animal)
    result <- strsplit(forest, '')[[1]]
    while (index < nchar(forest)) {
        result[index] <- substr(forest, index + 1, index + 1)
        index <- index + 1
    }
    if (index == nchar(forest)) {
        result[index] <- '-'
    }
    paste(result, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('2imo 12 tfiqr.', 'm'), '2io 12 tfiqr.-')))
}
test_humaneval()
