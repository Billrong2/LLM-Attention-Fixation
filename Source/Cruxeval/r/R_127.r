f <- function(text) {    s <- strsplit(text, "\n")[[1]]
    return(length(s))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('145\n\n12fjkjg'), 3)))
}
test_humaneval()
