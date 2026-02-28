f <- function(x) {    paste0(strsplit(x, '')[[1]][length(strsplit(x, '')[[1]]):1], collapse=' ')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('lert dna ndqmxohi3'), '3 i h o x m q d n   a n d   t r e l')))
}
test_humaneval()
