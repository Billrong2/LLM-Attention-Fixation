f <- function(text, space_symbol, size) {    spaces <- paste(rep(space_symbol, size - nchar(text)), collapse = "")
    return(paste0(text, spaces))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('w', '))', 7), 'w))))))))))))')))
}
test_humaneval()
