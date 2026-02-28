f <- function(n, m, text) {    if (trimws(text) == '') {
        return(text)
    }
    head <- substr(text, 1, 1)
    mid <- substr(text, 2, nchar(text)-1)
    tail <- substr(text, nchar(text), nchar(text))
    joined <- paste0(gsub(n, m, head), gsub(n, m, mid), gsub(n, m, tail))
    return(joined)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('x', '$', '2xz&5H3*1a@#a*1hris'), '2$z&5H3*1a@#a*1hris')))
}
test_humaneval()
