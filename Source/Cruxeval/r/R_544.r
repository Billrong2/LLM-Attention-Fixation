f <- function(text) {    a <- unlist(strsplit(text, "\n"))
    b <- lapply(a, function(x) gsub("\t", "    ", x))
    return(paste(b, collapse = "\n"))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('\t\t\ttab tab tabulates'), '            tab tab tabulates')))
}
test_humaneval()
