f <- function(d) {
    result <- vector("list", length = length(d))
    a <- b <- 0
    while (length(d) > 0) {
        keys <- as.integer(names(d))
        idx <- which(keys == b)
        result[[a + 1]] <- d[idx]
        d <- d[-idx]
        a <- b
        b <- (b + 1) %% length(result)
    }
    return(unlist(result))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), c())))
}
test_humaneval()
