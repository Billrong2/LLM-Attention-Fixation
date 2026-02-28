f <- function(array, elem) {    result <- array
    while(length(result) > 0) {
        key <- names(result)[length(result)]
        value <- result[[key]]
        if (identical(elem, key) || identical(elem, value)) {
            result <- c(result, array)
        }
        result <- result[!names(result) == key]
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(), 1), list())))
}
test_humaneval()
