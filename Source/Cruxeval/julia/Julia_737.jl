function f(nums::Vector{Int64})::Int64 
    counts = 0
    for i in nums
        if occursin(r"^\d+$", string(i))
            if counts == 0
                counts += 1
            end
        end
    end
    return counts
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 6, 2, -1, -2]) == 1)
end
