f <- function(s, c1, c2) {    if (s == '') {
        return(s)
    }
    ls <- strsplit(s, c1)[[1]]
    for (i in seq_along(ls)) {
        if (c1 %in% ls[i]) {
            ls[i] <- gsub(c1, c2, ls[i], fixed = TRUE)
        }
    }
    return(paste(ls, collapse = c1))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('', 'mi', 'siast'), '')))
}
test_humaneval()
