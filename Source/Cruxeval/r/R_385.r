f <- function(lst) {    i <- 1
    new_list <- c()
    while (i <= length(lst)) {
        if (lst[i] %in% lst[(i+1):length(lst)]) {
            new_list <- c(new_list, lst[i])
            if (length(new_list) == 3) {
                return(new_list)
            }
        }
        i <- i + 1
    }
    return(new_list)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 2, 1, 2, 6, 2, 6, 3, 0)), c(0, 2, 2))))
}
test_humaneval()
