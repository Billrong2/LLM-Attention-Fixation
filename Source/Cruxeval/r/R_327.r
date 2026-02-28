f <- function(lst) {
    new <- c()
    i <- length(lst)-1
    for (ind in 1:length(lst)) {
        if (i %% 2 == 0) {
            new <- c(new, -lst[i+1])
        }
        else {
            new <- c(new, lst[i+1])
        }
        i <- i-1
    }
    return(new)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 7, -1, -3)), c(-3, 1, 7, -1))))
}
test_humaneval()
