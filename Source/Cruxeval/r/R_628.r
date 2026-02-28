f <- function(nums, delete) {    nums <- nums[nums != delete]
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(4, 5, 3, 6, 1), 5), c(4, 3, 6, 1))))
}
test_humaneval()
