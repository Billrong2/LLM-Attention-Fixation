f <- function(text, speaker) {    while (startsWith(text, speaker)) {
        text <- substr(text, start = nchar(speaker) + 1, stop = nchar(text))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('[CHARRUNNERS]Do you know who the other was? [NEGMENDS]', '[CHARRUNNERS]'), 'Do you know who the other was? [NEGMENDS]')))
}
test_humaneval()
