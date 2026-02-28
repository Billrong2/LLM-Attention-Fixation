f <- function(text) {    ls <- strsplit(text, '')[[1]]
    ls <- rev(ls)
    text2 <- ''
    for (i in seq(3, length(ls), by = 3)) {
        text2 <- paste0(text2, paste(ls[i:(i + 2)], collapse = '---'), '---')
    }
    return(substring(text2, 1, nchar(text2) - 3))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('scala'), 'a---c---s')))
}
test_humaneval()
