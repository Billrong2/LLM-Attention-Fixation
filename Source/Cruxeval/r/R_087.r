f <- function(nums) {    rev_nums <- rev(nums)
    paste0(rev_nums, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, 9, 3, 1, -2)), '-2139-1')))
}
test_humaneval()
