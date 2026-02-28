f <- function(text, value) {    if (!grepl(value, text)) {
        return('')
    }
    parts <- strsplit(text, value)
    return(parts[[1]][1])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mmfbifen', 'i'), 'mmfb')))
}
test_humaneval()
