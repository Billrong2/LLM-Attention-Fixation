f <- function(s) {    s <- gsub('\"', '', s)
    lst <- strsplit(s, '')[[1]]
    col <- 1
    count <- 1
    while (col <= length(lst) && lst[col] %in% c('.', ':', ',')) {
        if (lst[col] == '.') {
            count <- lst[col] + 1
        }
        col <- col + 1
    }
    return(paste(lst[(col + count):length(lst)], collapse = ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('"Makers of a Statement"'), 'akers of a Statement')))
}
test_humaneval()
