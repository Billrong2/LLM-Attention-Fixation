function f(values::Vector{String})::Vector{String} 
    names = ["Pete", "Linda", "Angela"]
    append!(names, values)
    sort!(names)
    return names
end
using Test

@testset begin

candidate = f;
	@test(candidate(["Dan", "Joe", "Dusty"]) == ["Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"])
end
