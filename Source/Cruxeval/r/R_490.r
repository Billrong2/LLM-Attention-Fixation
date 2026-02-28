f <- function(s) {    paste0(unlist(strsplit(s, ""))[grepl("\\s", unlist(strsplit(s, "")))], collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('\ngiyixjkvu\n\r\r \x0crgjuo'), '\n\n\r\r \x0c')))
}
test_humaneval()
