f <- function(num) {    letter <- 1
    for (i in strsplit('1234567890', '')[[1]]) {
        num <- gsub(i, '', num)
        if (nchar(num) == 0) break
        num <- paste(substr(num, letter + 1, nchar(num)), substr(num, 1, letter), sep = '')
        letter <- letter + 1
    }
    return(num)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('bwmm7h'), 'mhbwm')))
}
test_humaneval()
