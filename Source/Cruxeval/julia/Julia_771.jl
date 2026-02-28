function f(items::Vector{Int64})::Vector{Int64} 
    odd_positioned = []
    while length(items) > 0
        position = findfirst(x -> x == minimum(items), items)
        splice!(items, position)
        item = splice!(items, position)
        push!(odd_positioned, item)
    end
    return odd_positioned
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4, 5, 6, 7, 8]) == [2, 4, 6, 8])
end
