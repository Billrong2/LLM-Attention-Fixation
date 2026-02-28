f <- function(s1, s2) {    for (k in 1:(nchar(s2) + nchar(s1))) {
        s1 <- paste0(s1, substr(s1, 1, 1))
        if (grepl(s2, s1)) {
            return(TRUE)
        }
    }
    return(FALSE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Hello', ')'), FALSE)))
}
test_humaneval()
