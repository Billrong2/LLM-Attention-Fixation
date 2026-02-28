f <- function(nums, target) {    lows <- c()
    higgs <- c()
    for (i in nums) {
        if (i < target) {
            lows <- c(lows, i)
        } else {
            higgs <- c(higgs, i)
        }
    }
    lows <- c()
    return(list(lows, higgs))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(12, 516, 5, 2, 3, 214, 51), 5), list(c(), c(12, 516, 5, 214, 51)))))
}
test_humaneval()
