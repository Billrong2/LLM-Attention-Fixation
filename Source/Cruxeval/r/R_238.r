f <- function(ls, n) {    answer <- 0
    for (i in ls) {
        if (i[1] == n) {
            answer <- i
        }
    }
    return(answer)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c(1, 9, 4), c(83, 0, 5), c(9, 6, 100)), 1), c(1, 9, 4))))
}
test_humaneval()
