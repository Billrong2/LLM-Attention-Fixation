f <- function(line, equalityMap) {
    rs <- setNames(sapply(equalityMap, `[`, 2), sapply(equalityMap, `[`, 1))
    chartr(paste(names(rs), collapse = ''), paste(rs, collapse = ''), line)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abab', list(c('a', 'b'), c('b', 'a'))), 'baba')))
}
test_humaneval()
