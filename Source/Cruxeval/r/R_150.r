f <- function(numbers, index) {    for (n in numbers[index:length(numbers)]) {
        numbers <- append(numbers, n, after = index)
        index <- index + 1
    }
    return(numbers[1:index])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-2, 4, -4), 0), c(-2, 4, -4))))
}
test_humaneval()
