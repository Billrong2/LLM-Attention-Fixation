f <- function(nums, sort_count) {    sorted_nums <- sort(nums)
    sorted_nums[1:sort_count]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 2, 3, 4, 5), 1), c(1))))
}
test_humaneval()
