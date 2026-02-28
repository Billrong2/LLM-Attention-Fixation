f <- function(ip, n) {    i <- 0
    out <- ''
    for (c in strsplit(ip, '')[[1]]) {
        if (i == n) {
            out <- paste(out, '\n', sep='')
            i <- 0
        }
        i <- i + 1
        out <- paste(out, c, sep='')
    }
    return(out)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dskjs hjcdjnxhjicnn', 4), 'dskj\ns hj\ncdjn\nxhji\ncnn')))
}
test_humaneval()
