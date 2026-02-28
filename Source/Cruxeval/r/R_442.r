f <- function(lst) {    res <- vector()
    for (i in seq_along(lst)) {
        if (lst[i] %% 2 == 0) {
            res <- c(res, lst[i])
        }
    }
    return(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4)), c(1, 2, 3, 4))))
}
test_humaneval()
