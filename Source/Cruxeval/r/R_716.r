f <- function(nums) {    count <- length(nums)
    while(length(nums) > (count %/% 2)) {
        nums <- c()
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 1, 2, 3, 1, 6, 3, 8)), c())))
}
test_humaneval()
