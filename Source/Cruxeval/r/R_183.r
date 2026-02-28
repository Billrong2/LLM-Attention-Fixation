f <- function(text) {    ls <- strsplit(text, " ")[[1]]
    lines <- strsplit(paste(ls[seq(1, length(ls), by=3)], collapse=" "), "\n")[[1]]
    res <- c()
    for (i in 0:1) {
        ln <- ls[seq(2, length(ls), by=3)]
        if (3 * i + 1 < length(ln)) {
            res <- c(res, paste(ln[3 * i + 1:(3 * (i + 1))], collapse=" "))
        }
    }
    c(lines, res)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('echo hello!!! nice!'), c('echo'))))
}
test_humaneval()
