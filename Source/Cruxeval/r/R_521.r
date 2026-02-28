f <- function(nums) {    m <- max(nums)
    for (i in seq_len(m)) {
        nums <- rev(nums)
    }
    nums
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(43, 0, 4, 77, 5, 2, 0, 9, 77)), c(77, 9, 0, 2, 5, 77, 4, 0, 43))))
}
test_humaneval()
