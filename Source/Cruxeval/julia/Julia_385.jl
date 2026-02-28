function f(lst::Vector{Int64})::Vector{Int64} 
    i = 1
    new_list = []
    while i <= length(lst)
        if lst[i] in lst[i+1:end]
            push!(new_list, lst[i])
            if length(new_list) == 3
                return new_list
            end
        end
        i += 1
    end
    return new_list
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 2, 1, 2, 6, 2, 6, 3, 0]) == [0, 2, 2])
end
