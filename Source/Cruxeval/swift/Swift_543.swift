import Foundation

func f(item: String) -> String {
    var modified = item.replacingOccurrences(of: ". ", with: " , ")
    modified = modified.replacingOccurrences(of: "&#33; ", with: "! ")
    modified = modified.replacingOccurrences(of: ". ", with: "? ")
    modified = modified.replacingOccurrences(of: ". ", with: ". ")
    
    if let first = modified.first {
        modified = first.uppercased() + modified.dropFirst()
    }
    
    return modified
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
            
assert(f(item: ".,,,,,. منبت") == ".,,,,, , منبت")
