f <- function(alphabet, s) {
    a <- c()
    for (x in strsplit(alphabet, '')[[1]]) {
        if (toupper(x) %in% toupper(s)) {
            a <- c(a, x)
        }
    }
    if (s == toupper(s)) {
        a <- c(a, 'all_uppercased')
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abcdefghijklmnopqrstuvwxyz', 'uppercased # % ^ @ ! vz.'), c())))
}
test_humaneval()
