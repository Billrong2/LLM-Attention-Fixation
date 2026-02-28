f <- function(text) {    b <- TRUE
    for (x in strsplit(text, split = '')[[1]]) {
        if (grepl("[0-9]", x)) {
            b <- TRUE
        } else {
            b <- FALSE
            break
        }
    }
    return(b)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('-1-3'), FALSE)))
}
test_humaneval()
