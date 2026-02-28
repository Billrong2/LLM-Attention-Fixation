f <- function(sequence, value) {    i <- max(regexpr(value, sequence)[1] - nchar(sequence) %/% 3, 1)
    result <- ''
    for (j in 1:(nchar(sequence) - i + 1)) {
        if (substr(sequence, i + j - 1, i + j - 1) == '+') {
            result <- paste0(result, value)
        } else {
            result <- paste0(result, substr(sequence, i + j - 1, i + j - 1))
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hosu', 'o'), 'hosu')))
}
test_humaneval()
