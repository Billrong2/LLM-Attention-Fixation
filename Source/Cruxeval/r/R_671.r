f <- function(text, char1, char2) {    t1a <- unlist(strsplit(char1, ""))
    t2a <- unlist(strsplit(char2, ""))
    t1 <- chartr(paste(t1a, collapse = ""), paste(t2a, collapse = ""), text)
    return(t1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ewriyat emf rwto segya', 'tey', 'dgo'), 'gwrioad gmf rwdo sggoa')))
}
test_humaneval()
