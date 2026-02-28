f <- function(name) {    new_name <- ''
    name <- strsplit(name, '')[[1]][rev(seq_len(nchar(name)))]
    for (i in seq_along(name)) {
        n <- name[i]
        if (n != '.' & sum(unlist(strsplit(new_name, '')) == '.') < 2) {
            new_name <- paste(n, new_name, sep = '')
        } else {
            break
        }
    }
    return(new_name)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('.NET'), 'NET')))
}
test_humaneval()
