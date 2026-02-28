import Foundation

func f(address: String) -> String {
    guard let atIndex = address.firstIndex(of: "@") else {
        return address
    }
    
    let suffixStart = address.index(after: atIndex)
    let suffix = address[suffixStart...]
    
    if suffix.components(separatedBy: ".").count > 2 {
        let parts = suffix.split(separator: ".")
        let removeSuffix = parts.prefix(2).joined(separator: ".")
        if let range = address.range(of: removeSuffix, options: .backwards) {
            return String(address[..<range.lowerBound])
        }
    }
    
    return address
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
            
assert(f(address: "minimc@minimc.io") == "minimc@minimc.io")
