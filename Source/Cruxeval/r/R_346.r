f <- function(filename) {    suffix <- tail(strsplit(filename, "\\."), 1)
    f2 <- paste0(filename, substring(suffix, nchar(suffix):1, nchar(suffix):1))
    return(suffix %in% strsplit(f2, "\\.")[[1]])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('docs.doc'), FALSE)))
}
test_humaneval()
