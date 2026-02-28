f <- function(s) {
    l <- strsplit(s, "")[[1]]
    for (i in seq_along(l)) {
        l[i] <- tolower(l[i])
        if (!is.numeric(as.integer(l[i]))) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(''), TRUE)))
}
test_humaneval()
