f <- function(text) {    result <- ''
    for (i in seq(nchar(text), 1, by = -1)) {
        result <- paste0(result, substr(text, i, i))
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('was,'), ',saw')))
}
test_humaneval()
