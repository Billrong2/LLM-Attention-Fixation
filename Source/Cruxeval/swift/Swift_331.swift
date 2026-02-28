import Foundation

func f(strand: String, zmnc: String) -> Int {    
    var strand = strand
    var poz = strand.range(of: zmnc)
    while poz != nil {
        strand.removeSubrange(poz!)
        poz = strand.range(of: zmnc)
    }
    let lastIndex = strand.range(of: zmnc, options: [], range: nil, locale: nil)?.lowerBound.utf16Offset(in: strand)
    return lastIndex ?? -1
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
            
assert(f(strand: "", zmnc: "abc") == -1)
