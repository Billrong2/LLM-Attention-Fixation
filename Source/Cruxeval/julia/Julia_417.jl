function f(lst::Vector{Int64})::Vector{Int64} 
    reverse!(lst)
    pop!(lst)
    reverse!(lst)
    return lst
end
using Test

@testset begin

candidate = f;
	@test(candidate([7, 8, 2, 8]) == [8, 2, 8])
end
