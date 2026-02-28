f <- function(text) {    tryCatch({
        return(all(strsplit(text, "")[[1]] %in% letters))
    }, error = function(e) {
        return(FALSE)
    })
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('x'), TRUE)))
}
test_humaneval()
