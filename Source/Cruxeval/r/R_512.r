f <- function(s) {    nchar(s) == sum(unlist(strsplit(s, "")) %in% c("0", "1"))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('102'), FALSE)))
}
test_humaneval()
