f <- function(text) {
    count <- 0
    lines <- strsplit(text, '\n')[[1]]
    for (line in lines) {
        if (grepl('^a', line)) {
            count <- count + gregexpr(' ', line)[[1]][1]
        } else {
            count <- count + nchar(line)
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a\nkgf\nasd\n'), 1)))
}
test_humaneval()
