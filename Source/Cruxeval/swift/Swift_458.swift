/// 
func f(text: String, search_chars: String, replace_chars: String) -> String {
    var trans_table: [Character: Character] = [:]
    for i in 0..<min(search_chars.count, replace_chars.count) {
        trans_table[search_chars[search_chars.index(search_chars.startIndex, offsetBy: i)]] = replace_chars[replace_chars.index(replace_chars.startIndex, offsetBy: i)]
    }
    var textArray = Array(text)
    for (index, char) in textArray.enumerated() {
        if let replacement = trans_table[char] {
            textArray[index] = replacement
        }
    }
    return String(textArray)
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
            
assert(f(text: "mmm34mIm", search_chars: "mm3", replace_chars: ",po") == "pppo4pIp")
