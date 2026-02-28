f <- function(text) {    text <- strsplit(text, '')[[1]]
    for (i in seq_along(text)) {
        if (text[i] == ' ') {
            text[i] <- '&nbsp;'
        }
    }
    paste(text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('   '), '&nbsp;&nbsp;&nbsp;')))
}
test_humaneval()
