import Foundation

func f(text: String, tab_size: Int) -> String {
    var res = ""
    let replacedText = text.replacingOccurrences(of: "\t", with: String(repeating: " ", count: tab_size-1))
    for i in 0..<replacedText.count {
        let char = replacedText[replacedText.index(replacedText.startIndex, offsetBy: i)]
        if char == " " {
            res += "|"
        } else {
            res += String(char)
        }
    }
    return res
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
            
assert(f(text: "\ta", tab_size: 3) == "||a")
