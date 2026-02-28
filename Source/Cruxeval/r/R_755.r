f <- function(replace, text, hide) {    while (grepl(hide, text, fixed=TRUE)) {
        replace <- paste0(replace, 'ax')
        text <- gsub(hide, replace, text, fixed=TRUE, perl=TRUE)
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('###', 'ph>t#A#BiEcDefW#ON#iiNCU', '.'), 'ph>t#A#BiEcDefW#ON#iiNCU')))
}
test_humaneval()
