f <- function(nums) {    asc <- rev(nums)
    desc <- asc[1:(length(asc)/2)]
    c(desc, asc, desc)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
