f <- function(n) {    if (grepl("\\.", as.character(n))) {
        return(as.character(as.numeric(n) + 2.5))
    } else {
        return(as.character(n))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('800'), '800')))
}
test_humaneval()
