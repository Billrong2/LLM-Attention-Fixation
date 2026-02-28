f <- function(text) {    i <- 1
    while (i <= nchar(text) && substr(text, i, i) == " ") {
        i <- i + 1
    }
    if (i > nchar(text)) {
        return('space')
    } else {
        return('no')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('     '), 'space')))
}
test_humaneval()
