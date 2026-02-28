f <- function(text, length, index) {    ls <- strsplit(text, " ")[[1]]
    ls <- rev(ls)
    result <- sapply(ls, function(x) substr(x, 1, length))
    paste(rev(result), collapse = "_")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hypernimovichyp', 2, 2), 'hy')))
}
test_humaneval()
