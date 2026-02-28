f <- function(text) {    words <- unlist(strsplit(text, " "))
    m <- 0
    cnt <- 0
    
    for (i in words) {
        if (nchar(i) > m) {
            cnt <- cnt + 1
            m <- nchar(i)
        }
    }
    
    return(cnt)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl'), 2)))
}
test_humaneval()
