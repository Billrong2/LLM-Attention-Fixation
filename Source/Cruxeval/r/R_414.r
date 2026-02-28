f <- function(d) {    dCopy <- d
    for (key in names(dCopy)) {
        for (i in seq_along(dCopy[[key]])) {
            dCopy[[key]][i] <- toupper(dCopy[[key]][i])
        }
    }
    return(dCopy)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'X'" = c('x', 'y'))), list("'X'" = c('X', 'Y')))))
}
test_humaneval()
