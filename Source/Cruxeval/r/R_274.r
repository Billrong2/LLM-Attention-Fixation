f <- function(nums, target) {    count <- 0
    for (n1 in nums) {
        for (n2 in nums) {
            count <- count + (n1 + n2 == target)
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3), 4), 3)))
}
test_humaneval()
