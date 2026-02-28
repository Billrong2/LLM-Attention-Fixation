f <- function(values, text, markers) {    text <- gsub(paste0('[', values, markers, ']*$'), '', text)
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('2Pn', 'yCxpg2C2Pny2', ''), 'yCxpg2C2Pny')))
}
test_humaneval()
