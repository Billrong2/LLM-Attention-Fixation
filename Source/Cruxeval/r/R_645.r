f <- function(nums, target) {    if (sum(nums == 0) > 0) {
        return(0)
    } else if (sum(nums == target) < 3) {
        return(1)
    } else {
        return(which(nums == target)[1])
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1, 1, 2), 3), 1)))
}
test_humaneval()
