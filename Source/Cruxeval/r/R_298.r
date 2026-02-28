f <- function(text) {    new_text <- strsplit(text, '')[[1]]
    for (i in 1:length(new_text)) {
        character <- new_text[i]
        new_character <- toupper(character)
        new_text[i] <- new_character
    }
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dst vavf n dmv dfvm gamcu dgcvb.'), 'DST VAVF N DMV DFVM GAMCU DGCVB.')))
}
test_humaneval()
