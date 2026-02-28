/// 
func f(text: String) -> String {
    var i = (text.count + 1) / 2
    var result = Array(text)
    while i < text.count {
        let t = result[i].lowercased()
        if t == String(result[i]) {
            i += 1
        } else {
            result[i] = Character(t)
        }
        i += 2
    }
    return String(result)
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
            
assert(f(text: "mJkLbn") == "mJklbn")
