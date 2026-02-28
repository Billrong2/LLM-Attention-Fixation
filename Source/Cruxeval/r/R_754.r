f <- function(nums) {    width <- as.numeric(nums[1])
    result <- lapply(nums[-1], function(val) {
        sprintf(paste0("%0", width, "d"), as.numeric(val))
    })
    return(as.character(result))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('1', '2', '2', '44', '0', '7', '20257')), c('2', '2', '44', '0', '7', '20257'))))
}
test_humaneval()
