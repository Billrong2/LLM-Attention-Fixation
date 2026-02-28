f <- function(text, position, value) {    length <- nchar(text)
    index <- (position %% (length + 2)) - 1
    if (index >= length || index < 0) {
        return(text)
    }
    text_list <- strsplit(text, '')[[1]]
    text_list[index + 1] <- value
    paste(text_list, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('1zd', 0, 'm'), '1zd')))
}
test_humaneval()
