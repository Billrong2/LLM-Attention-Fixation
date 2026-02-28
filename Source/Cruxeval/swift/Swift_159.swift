/// 
func f(st: String) -> String {
    var swapped = ""
    for ch in st.reversed() {
        swapped += String(ch).uppercased() == String(ch) ? String(ch).lowercased() : String(ch).uppercased()
    }
    return swapped
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
            
assert(f(st: "RTiGM") == "mgItr")
