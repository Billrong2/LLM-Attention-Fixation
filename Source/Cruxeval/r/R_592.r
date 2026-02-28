f <- function(numbers) {    new_numbers <- vector("numeric", length = length(numbers))
    for (i in 1:length(numbers)) {
        new_numbers[i] <- numbers[length(numbers) - i + 1]
    }
    return(new_numbers)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(11, 3)), c(3, 11))))
}
test_humaneval()
