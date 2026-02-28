f <- function(d) {    size <- length(d)
    v <- rep(0, size)
    if (size == 0) {
        return(v)
    }
    for (i in 1:size) {
        v[i] <- d[[i]]
    }
    return(v)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'a'" = 1, "'b'" = 2, "'c'" = 3)), c(1, 2, 3))))
}
test_humaneval()
