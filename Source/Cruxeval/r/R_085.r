f <- function(n) {
    values <- list('0' = 3, '1' = 4.5, '2' = '')
    res <- c()
    for (i in 0:(length(values)-1)) {
        if (i %% n != 2) {
            res[length(res)+1] <- values[[as.character(i)]]
        }
    }
    sort(res)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(12), c(3, 4.5))))
}
test_humaneval()
