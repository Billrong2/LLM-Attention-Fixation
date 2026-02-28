extension String: Error {}

func f(student_marks: [String : Int], name: String) -> Result<Int, String> {
    var mutableStudentMarks = student_marks
    if let value = mutableStudentMarks[name] {
        mutableStudentMarks[name] = nil
        return .success(value)
    }
    return .failure("Name unknown")
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
            
assert(f(student_marks: ["882afmfp" : 56], name: "6f53p") == .failure("Name unknown"))
