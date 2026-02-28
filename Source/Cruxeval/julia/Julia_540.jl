function f(a::Vector{Int64})::Vector{Int64} 
    b = copy(a)
    for k in 1:2:length(a)-1
        insert!(b, k+1, b[k])
    end
    push!(b, b[1])
    return b
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, 5, 5, 6, 4, 9]) == [5, 5, 5, 5, 5, 5, 6, 4, 9, 5])
end
