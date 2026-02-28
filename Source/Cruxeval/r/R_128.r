f <- function(text) {
    odd <- ''
    even <- ''
    for (i in seq_along(strsplit(text, '')[[1]])) {
        c <- substr(text, i, i)
        if ((i - 1) %% 2 == 0) {
            even <- paste0(even, c)
        } else {
            odd <- paste0(odd, c)
        }
    }
    return(paste0(even, tolower(odd)))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Mammoth'), 'Mmohamt')))
}
test_humaneval()
