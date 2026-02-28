f <- function(d) {    d <- d
    d[names(d)[length(d)]] <- NULL
    return(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'l'" = 1, "'t'" = 2, "'x:'" = 3)), list("'l'" = 1, "'t'" = 2))))
}
test_humaneval()
