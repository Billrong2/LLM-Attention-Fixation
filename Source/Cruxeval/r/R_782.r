f <- function(input) {    for (char in strsplit(input, '')[[1]]) {
        if (char %in% LETTERS) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a j c n x X k'), FALSE)))
}
test_humaneval()
