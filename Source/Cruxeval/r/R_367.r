f <- function(nums, rmvalue) {    res <- nums
    while (rmvalue %in% res) {
        popped <- res[which.max(res == rmvalue)]
        res <- res[-which(res == rmvalue)]
        if (popped != rmvalue) {
            res <- c(res, popped)
        }
    }
    return(res)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 2, 1, 1, 4, 1), 5), c(6, 2, 1, 1, 4, 1))))
}
test_humaneval()
