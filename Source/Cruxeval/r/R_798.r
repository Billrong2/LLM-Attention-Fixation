f <- function(text, pre) {    if (substring(text, 1, nchar(pre)) != pre) {
        return(text)
    } else {
        return(substring(text, nchar(pre) + 1))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('@hihu@!', '@hihu'), '@!')))
}
test_humaneval()
