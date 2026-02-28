function f(fruits::Vector{String})::Vector{String} 
    if fruits[end] == fruits[1]
        return ["no"]
    else
        popfirst!(fruits)
        popfirst!(fruits)
        pop!(fruits)
        pop!(fruits)
        return fruits
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(["apple", "apple", "pear", "banana", "pear", "orange", "orange"]) == ["pear", "banana", "pear"])
end
