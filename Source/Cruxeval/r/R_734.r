f <- function(nums) {    for (i in seq(length(nums), 1, by = -1)) {
        if (nums[i] %% 2 == 0) {
            nums <- nums[-i]
        }
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, 3, 3, 7)), c(5, 3, 3, 7))))
}
test_humaneval()
