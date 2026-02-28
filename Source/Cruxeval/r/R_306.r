f <- function(nums) {    digits <- c()
    for (num in nums) {
        if((is.numeric(num) && !is.na(num)) || (is.character(num) && grepl("^\\d+$", num))) {
            digits <- c(digits, as.integer(num))
        }
    }
    return(digits)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(0, 6, '1', '2', 0)), c(0, 6, 1, 2, 0))))
}
test_humaneval()
