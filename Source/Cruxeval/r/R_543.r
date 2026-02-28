f <- function(item) {    modified <- gsub('\\. ', ' , ', item)
    modified <- gsub('&#33; ', '! ', modified)
    modified <- gsub('\\? ', '? ', modified)
    modified <- gsub('\\. ', '. ', modified)
    
    modified <- paste0(toupper(substr(modified, 1, 1)), substr(modified, 2, nchar(modified)))
    
    return(modified)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('.,,,,,. منبت'), '.,,,,, , منبت')))
}
test_humaneval()
