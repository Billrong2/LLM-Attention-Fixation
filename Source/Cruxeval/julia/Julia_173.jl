function f(list_x::Vector{Int64})::Vector{Int64} 
    item_count = length(list_x)
    new_list = Vector{Int64}()
    for i in 1:item_count
        push!(new_list, pop!(list_x))
    end
    return new_list
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, 8, 6, 8, 4]) == [4, 8, 6, 8, 5])
end
