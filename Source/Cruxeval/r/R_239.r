f <- function(text, froms) {    
    text <- gsub(paste0('^[', froms, ']+'), '', text)
    text <- gsub(paste0('[', froms, ']+$'), '', text)
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('0 t 1cos ', 'st 0\t\n  '), '1co')))
}
test_humaneval()
