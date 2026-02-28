function f(array::Vector{Int64}, elem::Int64)::Int64 
    ind = findfirst(isequal(elem), array) - 1
    return ind * 2 + array[end - ind] * 3
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, 2, 1, -8, 2], 2) == -22)
end
