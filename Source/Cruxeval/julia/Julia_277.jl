function f(lst::Vector{Int64}, mode::Int64)::Vector{Int64} 
    result = copy(lst)
    if mode != 0
        reverse!(result)
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4], 1) == [4, 3, 2, 1])
end
