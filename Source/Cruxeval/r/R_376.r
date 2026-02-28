f <- function(text) {    for (i in seq_len(nchar(text))) {
        if (grepl("^two", substr(text, 1, i))) {
            return(substr(text, i+1, nchar(text)))
        }
    }
    return('no')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('2two programmers'), 'no')))
}
test_humaneval()
