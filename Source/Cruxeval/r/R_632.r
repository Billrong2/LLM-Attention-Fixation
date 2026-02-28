f <- function(lst) {    n <- length(lst)
    for (i in 1:(n-1)) {
        for (j in 1:(n-i)) {
            if (lst[j] > lst[j+1]) {
                temp <- lst[j]
                lst[j] <- lst[j+1]
                lst[j+1] <- temp
            }
        }
    }
    return(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(63, 0, 1, 5, 9, 87, 0, 7, 25, 4)), c(0, 0, 1, 4, 5, 7, 9, 25, 63, 87))))
}
test_humaneval()
