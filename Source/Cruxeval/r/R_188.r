f <- function(strings) {    new_strings <- c()
    for (string in strings) {
        first_two <- substr(string, 1, 2)
        if (startsWith(first_two, "a") || startsWith(first_two, "p")) {
            new_strings <- c(new_strings, first_two)
        }
    }
    return(new_strings)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('a', 'b', 'car', 'd')), c('a'))))
}
test_humaneval()
