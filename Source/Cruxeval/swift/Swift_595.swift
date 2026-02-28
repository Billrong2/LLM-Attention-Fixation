func f(text: String, prefix: String) -> String {
    var newText = text
    if newText.hasPrefix(prefix) {
        newText = String(newText.dropFirst(prefix.count))
    }
    newText = newText.prefix(1).uppercased() + newText.dropFirst()
    return newText
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
            
assert(f(text: "qdhstudentamxupuihbuztn", prefix: "jdm") == "Qdhstudentamxupuihbuztn")
