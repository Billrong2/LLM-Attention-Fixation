f <- function(text, value) {    length <- nchar(text)
    letters <- strsplit(text, '')[[1]]
    if (!(value %in% letters)) {
        value <- letters[1]
    }
    return(paste(rep(value, length), collapse = ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ldebgp o', 'o'), 'oooooooo')))
}
test_humaneval()
