f <- function(a_str, prefix) {
    # subtracting prefix length from a_str
    if (nchar(prefix) <= nchar(a_str)) { 
        # checking if prefix exists in a_str
        if (substr(a_str, 1, nchar(prefix)) == prefix) {
            return (substr(a_str, nchar(prefix)+1, nchar(a_str)))
        } else {
            return (paste(prefix, a_str, sep=""))
        }
    } else {
        return (a_str)
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abc', 'abcd'), 'abc')))
}
test_humaneval()
