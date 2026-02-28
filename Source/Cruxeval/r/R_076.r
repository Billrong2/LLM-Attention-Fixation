f <- function(nums) {    nums <- nums[nums > 0]
    if (length(nums) <= 3) {
        return(nums)
    }
    nums <- rev(nums)
    half <- length(nums) %/% 2
    return(c(nums[1:half], rep(0, 5), nums[(half+1):length(nums)]))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(10, 3, 2, 2, 6, 0)), c(6, 2, 0, 0, 0, 0, 0, 2, 3, 10))))
}
test_humaneval()
