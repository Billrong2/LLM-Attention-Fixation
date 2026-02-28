f <- function(dic) {    d <- list()
    while(length(dic) > 0){
        key <- names(dic)[1]
        d[[key]] <- dic[[key]]
        dic <- dic[-1]
    }
    return(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
