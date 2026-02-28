f <- function(text) {    result <- paste0(trimws(unlist(strsplit(text, "\\s+"))), collapse = " ")
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('pvtso'), 'pvtso')))
}
test_humaneval()
