function f(array::Vector{Int64}, i_num::Int64, elem::Int64)::Vector{Int64} 
    insert!(array, i_num + 1, elem)
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([-4, 1, 0], 1, 4) == [-4, 4, 1, 0])
end
