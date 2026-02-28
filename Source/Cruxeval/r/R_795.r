f <- function(text) {
    text <- tolower(text)
    text <- gsub("i o", "io", text)
    text <- gsub("(\\b[a-z])", "\\U\\1", text, perl = TRUE)
    return(text)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Fu,ux zfujijabji pfu.'), 'Fu,Ux Zfujijabji Pfu.')))
}
test_humaneval()
