function f(lst::Vector{Int64})::Vector{Int64} 
    for i in reverse(1:length(lst)-1)
        for j in 1:i
            if lst[j] > lst[j+1]
                lst[j], lst[j+1] = lst[j+1], lst[j]
            end
        end
    end
    return sort(lst)
end
using Test

@testset begin

candidate = f;
	@test(candidate([63, 0, 1, 5, 9, 87, 0, 7, 25, 4]) == [0, 0, 1, 4, 5, 7, 9, 25, 63, 87])
end
