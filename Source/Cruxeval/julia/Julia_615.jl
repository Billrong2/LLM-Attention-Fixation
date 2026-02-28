function f(in_list::Vector{Int64}, num::Int64)::Int64 
    push!(in_list, num)
    return findfirst(x -> x == maximum(in_list[1:end-1]), in_list[1:end-1]) - 1
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, 12, -6, -2], -1) == 1)
end
