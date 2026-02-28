f <- function(text) {    t <- 5
    tab <- character()
    for (i in strsplit(text, '')[[1]]) {
        if (tolower(i) %in% strsplit('aeiouy', '')[[1]]) {
            tab <- c(tab, paste(replicate(t, toupper(i)), collapse = ''))
        } else {
            tab <- c(tab, paste(replicate(t, i), collapse = ''))
        }
    }
    paste(tab, collapse = ' ')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('csharp'), 'ccccc sssss hhhhh AAAAA rrrrr ppppp')))
}
test_humaneval()
