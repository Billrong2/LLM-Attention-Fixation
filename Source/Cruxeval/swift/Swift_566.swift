import Foundation

func f(string: String, code: String) -> String {
    var t = ""
    do {
        if let data = string.data(using: .utf8) {
            t = String(data: data, encoding: .utf8) ?? ""
            if t.hasSuffix("\n") {
                t.removeLast()
            }
        }
    } catch {
        return t
    }
    return t
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
            
assert(f(string: "towaru", code: "UTF-8") == "towaru")
