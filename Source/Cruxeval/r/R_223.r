f <- function(array, target) {    count <- 0
    i <- 1
    for (j in 2:length(array)) {
        if (array[j] > array[j-1] & array[j] <= target) {
            count <- count + i
        } else if (array[j] <= array[j-1]) {
            i <- 1
        } else {
            i <- i + 1
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, -1, 4), 2), 1)))
}
test_humaneval()
