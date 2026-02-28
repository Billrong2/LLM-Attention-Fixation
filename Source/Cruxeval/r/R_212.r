f <- function(nums) {    for (i in 1:(length(nums) - 1)) {
        nums <- rev(nums)
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, -9, 7, 2, 6, -3, 3)), c(1, -9, 7, 2, 6, -3, 3))))
}
test_humaneval()
