function f(array::Vector{Int64}, L::Int64)::Vector{Int64}
    if L <= 0
        return array
    elseif length(array) < L
        append!(array, f(array, L - length(array)))
    end
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3], 4) == [1, 2, 3, 1, 2, 3])
end
