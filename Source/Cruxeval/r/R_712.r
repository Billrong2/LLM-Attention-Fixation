f <- function(text) {    created <- list()
    lines <- strsplit(text, "\n")[[1]]
    for (line in lines) {
        if (line == '') {
            break
        }
        created <- c(created, rev(strsplit(line, "")[[1]])[flush])
    }
    return(rev(created))
}

flush <- 1
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('A(hiccup)A'), list(c('A')))))
}
test_humaneval()
