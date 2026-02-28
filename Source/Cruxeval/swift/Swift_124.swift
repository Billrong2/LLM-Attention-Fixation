import Foundation

func f(txt: String, sep: String, sep_count: Int) -> String {
    var o = ""
    var txt = txt
    var sep_count = sep_count
    
    while sep_count > 0 && txt.contains(sep) {
        if let range = txt.range(of: sep, options: .backwards) {
            o += txt[..<range.lowerBound] + sep
            txt = String(txt[range.upperBound...])
        }
        sep_count -= 1
    }
    return o + txt
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
            
assert(f(txt: "i like you", sep: " ", sep_count: -1) == "i like you")
