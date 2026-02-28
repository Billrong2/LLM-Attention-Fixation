/// 
func f(text: String, value: String) -> String {
    var new_text = Array(text)
    do {
        new_text.append(Character(value))
        let length = new_text.count
        return "[" + String(length) + "]"
    } catch {
        return "[0]"
    }
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
            
assert(f(text: "abv", value: "a") == "[4]")
