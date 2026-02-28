f <- function(text, chars) {    listchars <- strsplit(chars, '')[[1]]
    first <- tail(listchars, 1)
    for (i in head(listchars, -1)) {
        text <- paste0(substr(text, 1, gregexpr(i, text)[[1]]), i, substr(text, gregexpr(i, text)[[1]] + 1, nchar(text)))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('tflb omn rtt', 'm'), 'tflb omn rtt')))
}
test_humaneval()
