f <- function(nums, index) {    
    val <- nums[index+1]
    nums <- nums[-(index+1)]
    return ((val %% 42) + val * 2)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 2, 0, 3, 7), 3), 9)))
}
test_humaneval()
