f <- function(names, excluded) {    excluded <- excluded
    for (i in seq_along(names)) {
        if (grepl(excluded, names[i])) {
            names[i] <- gsub(excluded, "", names[i])
        }
    }
    return(names)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('avc  a .d e'), ''), c('avc  a .d e'))))
}
test_humaneval()
