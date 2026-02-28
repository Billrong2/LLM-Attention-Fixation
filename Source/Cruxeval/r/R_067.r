f <- function(num1, num2, num3) {    nums <- c(num1, num2, num3)
    nums <- sort(nums)
    return(paste(nums[1], nums[2], nums[3], sep = ","))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(6, 8, 8), '6,8,8')))
}
test_humaneval()
