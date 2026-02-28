f <- function(arr1, arr2) {    new_arr <- c(arr1, arr2)
    return(new_arr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, 1, 3, 7, 8), list('', 0, -1, c())), list(5, 1, 3, 7, 8, '', 0, -1, c()))))
}
test_humaneval()
