f <- function(input_string) {    table <- chartr("aioe", "ioua", input_string)
    while("a" %in% strsplit(input_string, "")[[1]] | "A" %in% strsplit(input_string, "")[[1]]) {
        input_string <- chartr("aioe", "ioua", input_string)
    }
    return(input_string)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('biec'), 'biec')))
}
test_humaneval()
