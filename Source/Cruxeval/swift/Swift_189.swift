import Foundation

func f(out: String, mapping: [String : [String]]) -> String {
    var out = out
    for key in mapping.keys {
        let value = mapping[key]?.first ?? ""
        let replacement = String(value.reversed())
        out = out.replacingOccurrences(of: "{" + key + "}", with: replacement)
    }
    return out
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
            
assert(f(out: "{{{{}}}}", mapping: [:] as [String : [String]]) == "{{{{}}}}")
