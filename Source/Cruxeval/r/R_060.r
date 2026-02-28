f <- function(doc) {    for (x in strsplit(doc, '')[[1]]) {
        if (grepl('[A-Za-z]', x)) {
            return(toupper(x))
        }
    }
    return('-')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('raruwa'), 'R')))
}
test_humaneval()
