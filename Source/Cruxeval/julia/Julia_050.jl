function f(lst::Vector{String})::Vector{Int64} 
    lst = []
    for i in 1:length(lst) + 1
        push!(lst, 1)
    end
    return lst
end
using Test

@testset begin

candidate = f;
	@test(candidate(["a", "c", "v"]) == [1])
end
