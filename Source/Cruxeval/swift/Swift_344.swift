import Foundation

func f(lst: [Int]) -> [Int] {
    var newList = lst
    newList.sort()
    newList.reverse()
    return lst
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
            
assert(f(lst: [6, 4, 2, 8, 15]) == [6, 4, 2, 8, 15])
