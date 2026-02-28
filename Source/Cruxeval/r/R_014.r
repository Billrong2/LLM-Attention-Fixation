f <- function(s) {    arr <- strsplit(trimws(s), '')[[1]]
    arr <- rev(arr)
    paste(arr, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('   OOP   '), 'POO')))
}
test_humaneval()
