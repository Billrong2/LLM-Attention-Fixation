f <- function(nums, odd1, odd2) {    while(odd1 %in% nums) {
        nums <- nums[nums != odd1]
    }
    while(odd2 %in% nums) {
        nums <- nums[nums != odd2]
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3), 3, 1), c(2, 7, 7, 6, 8, 4, 2, 5, 21))))
}
test_humaneval()
