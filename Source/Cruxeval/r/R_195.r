f <- function(text) {    for (p in c('acs', 'asp', 'scn')) {
        if (startsWith(text, p)) {
            text <- substr(text, nchar(p) + 1, nchar(text))
        }
        text <- paste0(text, ' ')
    }
    if (startsWith(text, ' ')) {
        text <- substr(text, 2, nchar(text))
    }
    return(substr(text, 1, nchar(text) - 1))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ilfdoirwirmtoibsac'), 'ilfdoirwirmtoibsac  ')))
}
test_humaneval()
