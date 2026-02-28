function f(lst::Vector{Int64})::Bool 
    lst = []
    for i in lst
        if i == 3
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 0]) == true)
end
