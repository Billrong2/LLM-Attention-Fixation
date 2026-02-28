f <- function(text) {    if (grepl("^[a-z]+$", text)) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('54882'), FALSE)))
}
test_humaneval()
