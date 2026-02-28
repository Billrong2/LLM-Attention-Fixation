f <- function(numbers, num, val) {
    while (length(numbers) < num) {
        numbers <- append(numbers, as.character(val), after = floor(length(numbers) / 2))
    }
    if (num > 1) {
        for (i in 1:(floor(length(numbers) / (num - 1)) - 4)) {
            numbers <- append(numbers, as.character(val), after = floor(length(numbers) / 2))
        }
    }
    return(paste(numbers, collapse = ' '))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(), 0, 1), '')))
}
test_humaneval()
