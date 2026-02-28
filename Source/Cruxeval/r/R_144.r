f <- function(vectors) {
    if (is.null(vectors) || length(vectors) == 0) {
        return(c())
    }
    sorted_vecs <- lapply(vectors, sort)
    return(sorted_vecs)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
