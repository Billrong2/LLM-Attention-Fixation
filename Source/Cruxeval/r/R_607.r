f <- function(text) {    for (i in c('.', '!', '?')) {
        if (substring(text, nchar(text), nchar(text)) == i) {
            return(TRUE)
        }
    }
    return(FALSE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('. C.'), TRUE)))
}
test_humaneval()
