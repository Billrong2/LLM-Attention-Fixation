f <- function(row) {    count_1 <- nchar(gsub("[^1]", "", row))
    count_0 <- nchar(gsub("[^0]", "", row))
    return(c(count_1, count_0))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('100010010'), c(3, 6))))
}
test_humaneval()
