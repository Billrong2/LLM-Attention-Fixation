f <- function(n, l) {    archive <- list()
    for (i in seq_len(n)) {
        archive <- list()
        for (x in l) {
            archive[[as.character(as.integer(x) + 10)]] <- as.integer(x) * 10
        }
    }
    return(archive)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(0, c('aaa', 'bbb')), list())))
}
test_humaneval()
