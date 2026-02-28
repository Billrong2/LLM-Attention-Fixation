f <- function(var) {    if (grepl("^\\d+$", var)) {
        return("int")
    } else if (grepl("^\\d+\\.\\d+$", var)) {
        return("float")
    } else if (nchar(gsub("\\s+", "", var)) == 0) {
        return("str")
    } else if (nchar(var) == 1) {
        return("char")
    } else {
        return("tuple")
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(' 99 777'), 'tuple')))
}
test_humaneval()
