f <- function(nums) {    count <- 1
    for (i in seq(count, length(nums) - 1, by=2)) {
        nums[i] <- max(nums[i], nums[count])
        count <- count + 1
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3)), c(1, 2, 3))))
}
test_humaneval()
