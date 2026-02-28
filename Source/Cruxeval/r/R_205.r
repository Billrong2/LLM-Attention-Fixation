f <- function(a) {    for (i in 1:10) {
        for (j in 1:nchar(a)) {
            if (substring(a, j, j) != '#') {
                a = substr(a, j, nchar(a))
                break
            } else if (j == nchar(a)) {
                a = ""
                break
            }
        }
    }
    while (substr(a, nchar(a), nchar(a)) == '#') {
        a = substr(a, 1, nchar(a)-1)
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('##fiu##nk#he###wumun##'), 'fiu##nk#he###wumun')))
}
test_humaneval()
