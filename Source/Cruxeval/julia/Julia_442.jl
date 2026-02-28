function f(lst::Vector{Int64})::Vector{Int64} 
    res = Int64[]
    for i in 1:length(lst)
        if lst[i] % 2 == 0
            push!(res, lst[i])
        end
    end
    
    return copy(lst)
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4]) == [1, 2, 3, 4])
end
