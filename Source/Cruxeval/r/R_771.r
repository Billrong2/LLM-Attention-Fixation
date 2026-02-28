f <- function(items) {    odd_positioned <- c()
    while (length(items) > 0) {
        position <- which.min(items)
        item <- items[position + 1]
        items <- items[-c(position, position + 1)]
        odd_positioned <- c(odd_positioned, item)
    }
    return(odd_positioned)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4, 5, 6, 7, 8)), c(2, 4, 6, 8))))
}
test_humaneval()
