f <- function(t) {    all(grepl("^\\d+$", strsplit(t, "")[[1]]))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('#284376598'), FALSE)))
}
test_humaneval()
