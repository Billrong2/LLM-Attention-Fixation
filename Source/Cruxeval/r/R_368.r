f <- function(string, numbers) {    arr <- lapply(numbers, function(num) {
        sprintf("%0*d", num, as.numeric(string))
    })
    paste(arr, collapse = ' ')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('4327', c(2, 8, 9, 2, 7, 1)), '4327 00004327 000004327 4327 0004327 4327')))
}
test_humaneval()
