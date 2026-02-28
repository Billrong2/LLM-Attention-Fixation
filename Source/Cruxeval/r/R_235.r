f <- function(array, arr) {    result <- c()
    for (s in arr) {
        result <- c(result, unlist(strsplit(s, arr[which(arr == s)])))
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(), c()), c())))
}
test_humaneval()
