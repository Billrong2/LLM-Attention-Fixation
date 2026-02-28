f <- function(nums) {    count <- length(nums)
    score <- list(`0` = "F", `1` = "E", `2` = "D", `3` = "C", `4` = "B", `5` = "A", `6` = "")
    result <- character(count)
    
    for (i in 1:count) {
        result[i] <- score[[as.character(nums[i])]]
    }
    
    paste(result, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(4, 5)), 'BA')))
}
test_humaneval()
