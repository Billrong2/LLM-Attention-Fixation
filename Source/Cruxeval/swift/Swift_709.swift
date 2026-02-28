/// 
func f(text: String) -> String {
    let my_list = text.split(separator: " ")
    let sortedList = my_list.sorted(by: >)
    return sortedList.joined(separator: " ")
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
            
assert(f(text: "a loved") == "loved a")
