/// 
func f(array: [Int]) -> [Int] {
    var output = array
    output[0..<output.count].forEach { index in
        if index % 2 == 0 {
            output[index] = array[array.count - 1 - index]
        }
    }
    return output.reversed()
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
            
assert(f(array: [] as [Int]) == [] as [Int])
