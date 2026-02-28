function f(s::Vector{Int64})::Int64 
    while length(s) > 1
        empty!(s)
        push!(s, length(s))
    end
    return pop!(s)
end
using Test

@testset begin

candidate = f;
	@test(candidate([6, 1, 2, 3]) == 0)
end
