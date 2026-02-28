f <- function(concat, di) {    count <- length(di)
    for (i in 1:count) {
        if (as.character(i) %in% di && di[[as.character(i)]] %in% concat) {
            di[[as.character(i)]] <- NULL
        }
    }
    return("Done!")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mid', list("'0'" = 'q', "'1'" = 'f', "'2'" = 'w', "'3'" = 'i')), 'Done!')))
}
test_humaneval()
