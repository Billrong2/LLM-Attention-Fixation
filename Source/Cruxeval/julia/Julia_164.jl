function f(lst::Vector{Int64})::Vector{Int64} 
    sort!(lst)
    return lst[1:3]
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, 8, 1, 3, 0]) == [0, 1, 3])
end
