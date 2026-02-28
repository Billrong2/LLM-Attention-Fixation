f <- function(text, count) {    
    for (i in 1:count) {
        text = rev(strsplit(text, "")[[1]])
        text = paste(text, collapse='')
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('439m2670hlsw', 3), 'wslh0762m934')))
}
test_humaneval()
