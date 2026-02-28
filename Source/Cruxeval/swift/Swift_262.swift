/// 
func f(nums: [Int]) -> String {
    let score = [0: "F", 1: "E", 2: "D", 3: "C", 4: "B", 5: "A", 6: ""]
    var result = [String]()
    for num in nums {
        result.append(score[num] ?? "")
    }
    return result.joined()
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
            
assert(f(nums: [4, 5]) == "BA")
