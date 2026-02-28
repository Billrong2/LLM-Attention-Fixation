function f(L::Vector{Int64}, m::Int64, start::Int64, step::Int64)::Vector{Int64}
    insert!(L, start+1, m)
    for x in start-1:-step:0
        start -= 1
        insertionPoint = findlast(x -> x == m, L)
        insertionPoint != nothing && start >= insertionPoint >= (x-step+1) ? insertionPoint = (insertionPoint - step + 1) : nothing
        insert!(L, insertionPoint, popat!(L, findlast(x -> x == m, L)))
    end
    return L
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 7, 9], 3, 3, 2) == [1, 2, 7, 3, 9])
end
