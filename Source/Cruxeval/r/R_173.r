f <- function(list_x) {    item_count <- length(list_x)
    new_list <- numeric(0)
    for (i in 1:item_count) {
        new_list <- c(new_list, tail(list_x, 1))
        list_x <- head(list_x, -1)
    }
    new_list
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, 8, 6, 8, 4)), c(4, 8, 6, 8, 5))))
}
test_humaneval()
