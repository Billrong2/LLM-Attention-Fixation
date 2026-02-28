f <- function(nums) {    output <- list()
    for (n in nums) {
        count <- sum(nums == n)
        output <- c(output, list(c(count, n)))
    }
    output <- output[order(sapply(output, `[[`, 1), decreasing = TRUE)]
    return(output)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1, 3, 1, 3, 1)), list(c(4, 1), c(4, 1), c(4, 1), c(4, 1), c(2, 3), c(2, 3)))))
}
test_humaneval()
