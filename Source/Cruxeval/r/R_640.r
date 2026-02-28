f <- function(text) {    
    a <- 0
    if (strsplit(text, '')[[1]][1] %in% strsplit(text, '')[[1]][2:length(text)]) {
        a <- a + 1
    }
    for (i in 1:(nchar(text)-1)) {
        if (strsplit(text, '')[[1]][i] %in% strsplit(text, '')[[1]][(i+1):nchar(text)]) {
            a <- a + 1
        }
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('3eeeeeeoopppppppw14film3oee3'), 18)))
}
test_humaneval()
