function f(arr::Vector{Int64})::Vector{Int64} 
    count = length(arr)
    sub = copy(arr)
    for i in 1:2:count
        sub[i] *= 5
    end
    return sub
end
using Test

@testset begin

candidate = f;
	@test(candidate([-3, -6, 2, 7]) == [-15, -6, 10, 7])
end
