function f(first::Vector{Int64}, second::Vector{Int64})::Union{String, Vector{Int64}} 
    if length(first) < 10 || length(second) < 10
        return "no"
    end
    
    for i in 1:5
        if first[i] != second[i]
            return "no"
        end
    end
    
    append!(first, second)
    return first
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 1], [1, 1, 2]) == "no")
end
