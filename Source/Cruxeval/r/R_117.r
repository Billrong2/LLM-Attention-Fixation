f <- function(numbers) {    for (i in 1:nchar(numbers)) {
        if (sum(strsplit(numbers, '')[[1]] == '3') > 1) {
            return(i)
        }
    }
    return(-1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('23157'), -1)))
}
test_humaneval()
