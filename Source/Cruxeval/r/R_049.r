f <- function(text) {    if (grepl("^[a-zA-Z_][a-zA-Z0-9_]*$", text)) {
        paste0(gsub("\\D", "", strsplit(text, "")[[1]]))
    } else {
        paste0(strsplit(text, "")[[1]], collapse = "")
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('816'), '816')))
}
test_humaneval()
