f <- function(text) {    for (char in strsplit(text, '')[[1]]) {
        if (char != " ") {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('     i'), FALSE)))
}
test_humaneval()
