f <- function(k, j) {    arr <- vector(length = k)
    for (i in 1:k) {
        arr[i] <- j
    }
    return(arr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(7, 5), c(5, 5, 5, 5, 5, 5, 5))))
}
test_humaneval()
