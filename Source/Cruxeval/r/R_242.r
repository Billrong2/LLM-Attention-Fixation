f <- function(book) {    a <- strsplit(book, ":")[[1]]
    if (tail(strsplit(a[1], " ")[[1]], 1) == head(strsplit(a[2], " ")[[1]], 1)) {
        f(paste(paste(head(strsplit(a[1], " ")[[1]], -1), collapse = " "), a[2]))
    } else {
        return(book)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('udhv zcvi nhtnfyd :erwuyawa pun'), 'udhv zcvi nhtnfyd :erwuyawa pun')))
}
test_humaneval()
