f <- function(char) {if (char %in% c('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U')) {
        if (char %in% c('A', 'E', 'I', 'O', 'U')) {
            return(tolower(char))
        } else {
            return(toupper(char))
        }
    } else {
        return(NULL)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('o'), 'O')))
}
test_humaneval()
