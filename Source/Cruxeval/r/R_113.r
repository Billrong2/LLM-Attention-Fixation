f <- function(line) {    count <- 0
    a <- character()
    for (i in 1:nchar(line)) {
        count <- count + 1
        if (count %% 2 == 0) {
            a <- c(a, chartr('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', substr(line, i, i)))
        } else {
            a <- c(a, substr(line, i, i))
        }
    }
    paste(a, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('987yhNSHAshd 93275yrgSgbgSshfbsfB'), '987YhnShAShD 93275yRgsgBgssHfBsFB')))
}
test_humaneval()
