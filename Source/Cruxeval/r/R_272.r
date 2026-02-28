f <- function(base_list, nums) {
    base_list <- append(base_list, nums)
    res <- base_list
    for (i in seq(from = length(nums), to = 1)) {
        res <- append(res, res[length(res) - i + 1])
    }
    return(res)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(9, 7, 5, 3, 1), c(2, 4, 6, 8, 0)), c(9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6))))
}
test_humaneval()
