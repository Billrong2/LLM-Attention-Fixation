f <- function(li) {    output <- numeric(length(li))
    for (i in 1:length(li)) {
        output[i] <- sum(li == li[i])
    }
    output
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('k', 'x', 'c', 'x', 'x', 'b', 'l', 'f', 'r', 'n', 'g')), c(1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1))))
}
test_humaneval()
