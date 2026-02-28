f <- function(text) {    ans <- sapply(strsplit(text, '')[[1]], function(char) ifelse(is.na(as.numeric(char)), ' ', char))
    paste(ans, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('m4n2o'), ' 4 2 ')))
}
test_humaneval()
