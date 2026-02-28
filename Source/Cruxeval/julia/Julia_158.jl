function f(arr::Vector{Int64})::Vector{Int64} 
    n = [item for item in arr if item%2 == 0]
    m = vcat(n, arr)
    for i in m
        if findfirst(x->x==i, m) > length(n)
            deleteat!(m, findfirst(x->x==i, m))
        end
    end
    return m
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 6, 4, -2, 5]) == [6, 4, -2, 6, 4, -2])
end
