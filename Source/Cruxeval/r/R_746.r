f <- function(dct) {    values <- unlist(dct)
    result <- vector("list", length = length(values))
    for(i in seq_along(values)){
        item <- paste0(strsplit(values[i], '.', fixed = TRUE)[[1]][1], '@pinc.uk')
        result[i] <- item
    }
    names(result) <- values
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
