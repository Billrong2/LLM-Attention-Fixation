f <- function(txt) {    d <- character()
    for (c in strsplit(txt, '')[[1]]) {
        if (grepl("[0-9]", c)) {
            next
        }
        if (grepl("[a-z]", c)) {
            d <- c(d, toupper(c))
        } else if (grepl("[A-Z]", c)) {
            d <- c(d, tolower(c))
        }
    }
    paste(d, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('5ll6'), 'LL')))
}
test_humaneval()
