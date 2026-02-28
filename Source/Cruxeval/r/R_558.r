f <- function(nums, mos) {    for (num in mos) {
        nums <- nums[-which(nums == num)]
    }
    nums <- sort(nums)
    for (num in mos) {
        nums <- c(nums, num)
    }
    for (i in 1:(length(nums)-1)) {
        if (nums[i] > nums[i+1]) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 1, 2, 1, 4, 1), c(1)), FALSE)))
}
test_humaneval()
