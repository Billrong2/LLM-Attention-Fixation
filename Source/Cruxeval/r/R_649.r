f <- function(text, tabsize) {    paste(
        lapply(strsplit(text, "\n")[[1]], function(t) {
            gsub("\t", paste(rep(" ", tabsize), collapse = ""), t)
        }),
        collapse = "\n"
    )
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('\tf9\n\tldf9\n\tadf9!\n\tf9?', 1), ' f9\n ldf9\n adf9!\n f9?')))
}
test_humaneval()
