f <- function(text) {    ls <- strsplit(text, '')[[1]]
    for (x in seq_along(ls)) {
        if (length(ls) <= 1) break
        if (!(ls[x] %in% strsplit('zyxwvutsrqponmlkjihgfedcba', '')[[1]])) {
            ls <- ls[-x]
        }
    }
    paste(ls, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qq'), 'qq')))
}
test_humaneval()
