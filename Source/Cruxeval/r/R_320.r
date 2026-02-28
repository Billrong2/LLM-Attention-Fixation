f <- function(text) {    index <- 2
    while (index <= nchar(text)) {
        if (substr(text, index, index) != substr(text, index - 1, index - 1)) {
            index <- index + 1
        } else {
            text1 <- substr(text, 1, index - 1)
            text2 <- chartr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
                            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
                            substr(text, index, nchar(text)))
            return(paste0(text1, text2))
        }
    }
    return(chartr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
                  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
                  text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('USaR'), 'usAr')))
}
test_humaneval()
