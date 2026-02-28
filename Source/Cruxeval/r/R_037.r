f <- function(text) {    text_arr <- vector(mode = "character", length = nchar(text))
    for (j in 1:nchar(text)) {
        text_arr[j] <- substr(text, j, nchar(text))
    }
    return(text_arr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('123'), c('123', '23', '3'))))
}
test_humaneval()
