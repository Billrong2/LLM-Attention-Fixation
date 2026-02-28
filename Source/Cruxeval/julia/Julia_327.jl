function f(lst::Vector{Int64})::Vector{Int64} 
    new = Int64[]
    i = length(lst)
    for _ in 1:length(lst)
        if i % 2 == 1
            push!(new, -lst[i])
        else
            push!(new, lst[i])
        end
        i -= 1
    end
    return new
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 7, -1, -3]) == [-3, 1, 7, -1])
end
