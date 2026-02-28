f <- function(text, wrong, right) {    new_text <- toupper(gsub(wrong, right, text))
    return(new_text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('zn kgd jw lnt', 'h', 'u'), 'ZN KGD JW LNT')))
}
test_humaneval()
