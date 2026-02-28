f <- function(text, res) {    for (c in c('*', '\n', '\"')) {
        text <- gsub(c, paste0('!', res), text, fixed = TRUE)
    }
    if (substr(text, 1, 1) == '!') {
        text <- substr(text, nchar(as.character(res)) + 1, nchar(text))
    }
    text
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('"Leap and the net will appear', 123), '3Leap and the net will appear')))
}
test_humaneval()
