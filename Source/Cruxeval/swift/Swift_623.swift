/// 
func f(text: String, rules: [String]) -> String {
    var modifiedText = text
    for rule in rules {
        if rule == "@" {
            modifiedText = String(modifiedText.reversed())
        } else if rule == "~" {
            modifiedText = modifiedText.uppercased()
        } else if !modifiedText.isEmpty, modifiedText.last == Character(rule) {
            modifiedText = String(modifiedText.dropLast())
        }
    }
    return modifiedText
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
            
assert(f(text: "hi~!", rules: ["~", "`", "!", "&"]) == "HI~")
