f <- function(body) {
    ls <- strsplit(body, "")[[1]]
    dist <- 0
    for (i in 1:(length(ls) - 1)) {
        if (ls[max(i - 2, 1)] == '\t') {
            dist <- dist + (1 + sum(unlist(strsplit(ls[max(i - 1, 1)],'\t')))) * 3
        }
        ls[i] <- paste0('[', ls[i], ']')
    }
    return(paste0(ls, collapse = ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('\n\ny\n'), '[\n][\n][y]\n')))
}
test_humaneval()
