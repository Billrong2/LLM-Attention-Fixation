f <- function(lst) {    operation <- function(x) {
        x <- rev(x)
    }
    new_list <- lst
    new_list <- sort(new_list)
    operation(new_list)
    return(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 4, 2, 8, 15)), c(6, 4, 2, 8, 15))))
}
test_humaneval()
