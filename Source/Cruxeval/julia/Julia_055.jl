function f(array::Vector{Int64})::Vector{Int64} 
    array_2 = Int64[]
    for i in array
        if i > 0
            push!(array_2, i)
        end
    end
    sort!(array_2, rev=true)
    return array_2
end
using Test

@testset begin

candidate = f;
	@test(candidate([4, 8, 17, 89, 43, 14]) == [89, 43, 17, 14, 8, 4])
end
