f <- function(nums) {
    count <- 0
    while (length(nums) > 0) {
        if (count %% 2 == 0) {
            nums <- nums[-length(nums)]
        } else {
            nums <- nums[-1]
        }
        count <- count + 1
    }
    if (identical(nums, numeric(0))) {
        nums <- c()
    }
    return(nums)
}


test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 2, 0, 0, 2, 3)), c())))
}
test_humaneval()
