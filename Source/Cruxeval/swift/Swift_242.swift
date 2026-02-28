func f(book: String) -> String {
    var a = book.split(separator: ":")
    if a[0].split(separator: " ").last == a[1].split(separator: " ").first {
        return f(book: a[0].split(separator: " ").dropLast().joined(separator: " ") + " " + a[1])
    }
    return book
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(book: "udhv zcvi nhtnfyd :erwuyawa pun") == "udhv zcvi nhtnfyd :erwuyawa pun")
