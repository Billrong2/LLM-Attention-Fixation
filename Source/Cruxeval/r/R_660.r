f <- function(num) {
    initial <- c(1)
    total <- initial
    for (i in 1:num) {
        total <- c(1, total[-1] + total[-length(total)])
        initial <- c(initial, total[length(total)])
    }
    return(sum(initial))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(3), 4)))
}
test_humaneval()
