function f(list1::Vector{Int64}, list2::Vector{Int64})::Union{Int64, String} 
    l = copy(list1)
    while length(l) > 0
        if l[end] in list2
            pop!(l)
        else
            return l[end]
        end
    end
    return "missing"
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 4, 5, 6], [13, 23, -5, 0]) == 6)
end
