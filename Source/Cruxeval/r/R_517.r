f <- function(text) {    for (i in (nchar(text):1)) {
        if (!grepl("[A-Z]", substr(text, i, i))) {
            return(substr(text, 1, i - 1))
        }
    }
    return('')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('SzHjifnzog'), 'SzHjifnzo')))
}
test_humaneval()
