function f(orig::Vector{Int64})::Vector{Int64}
    copy = orig
    push!(copy, 100)
    popat!(orig, length(orig))
    return copy
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3]) == [1, 2, 3])
end
