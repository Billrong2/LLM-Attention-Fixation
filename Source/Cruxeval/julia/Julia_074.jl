function f(lst::Vector{Int64}, i::Int64, n::Int64)::Vector{Int64} 
    insert!(lst, i+1, n)
    return lst
end
using Test

@testset begin

candidate = f;
	@test(candidate([44, 34, 23, 82, 24, 11, 63, 99], 4, 15) == [44, 34, 23, 82, 15, 24, 11, 63, 99])
end
