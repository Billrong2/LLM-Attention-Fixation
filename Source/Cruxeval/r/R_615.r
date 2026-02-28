f <- function(in_list, num) {    in_list <- c(in_list, num)
    return(which.max(in_list[1:length(in_list) - 1]) - 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, 12, -6, -2), -1), 1)))
}
test_humaneval()
