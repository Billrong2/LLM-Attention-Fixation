function f(a::Vector{Int64})::Vector{Int64} 
    if length(a) >= 2 && a[1] > 0 && a[2] > 0
        reverse!(a)
        return a
    end
    push!(a, 0)
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == [0])
end
