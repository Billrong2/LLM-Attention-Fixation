f <- function(text, characters) {    character_list <- c(strsplit(characters, '')[[1]], ' ', '_')
    
    i <- 1
    while (i <= nchar(text) && substr(text, i, i) %in% character_list) {
        i <- i + 1
    }
    
    substr(text, i, nchar(text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('2nm_28in', 'nm'), '2nm_28in')))
}
test_humaneval()
