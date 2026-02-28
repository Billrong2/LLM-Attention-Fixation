f <- function(array) {
    just_ns <- lapply(array, function(num) paste(rep("n", num), collapse=""))
    final_output <- unlist(just_ns)
    return(final_output)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
