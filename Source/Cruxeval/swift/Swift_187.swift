import Foundation

func f(d: [Int : Int], index: Int) -> Int {
    var d = d
    let length = d.count
    let idx = index % length
    let v = d.popFirst()!.value
    for _ in 0..<idx {
        d.popFirst()
    }
    return v
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
            
assert(f(d: [27 : 39], index: 1) == 39)
