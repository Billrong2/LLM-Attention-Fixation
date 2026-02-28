f <- function(nums) {    count <- length(nums)
    for (i in 1:(count %/% 2)) {
        temp <- nums[i]
        nums[i] <- nums[count-i+1]
        nums[count-i+1] <- temp
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 6, 1, 3, 1)), c(1, 3, 1, 6, 2))))
}
test_humaneval()
