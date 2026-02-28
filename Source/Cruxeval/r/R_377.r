f <- function(text) {    return(paste(strsplit(text, "\n")[[1]], collapse = ", "))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('BYE\nNO\nWAY'), 'BYE, NO, WAY')))
}
test_humaneval()
