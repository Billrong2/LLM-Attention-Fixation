function f(num::Vector{Int64})::Vector{Int64} 
    push!(num, num[end])
    return num
end
using Test

@testset begin

candidate = f;
	@test(candidate([-70, 20, 9, 1]) == [-70, 20, 9, 1, 1])
end
