function f(k::Int64, j::Int64)::Vector{Int64} 
    arr = Int64[]
    for i in 1:k
        push!(arr, j)
    end
    return arr
end
using Test

@testset begin

candidate = f;
	@test(candidate(7, 5) == [5, 5, 5, 5, 5, 5, 5])
end
