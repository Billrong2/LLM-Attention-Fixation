f <- function(text, search) {    result <- tolower(text)
    return(gregexpr(tolower(search), result)[[1]][1] - 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('car hat', 'car'), 0)))
}
test_humaneval()
