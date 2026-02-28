f <- function(a, split_on) {    t <- unlist(strsplit(a, split = ""))
    if (split_on %in% t) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('booty boot-boot bootclass', 'k'), FALSE)))
}
test_humaneval()
