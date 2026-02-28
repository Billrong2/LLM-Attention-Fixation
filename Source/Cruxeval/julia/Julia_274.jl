function f(nums::Vector{Int64}, target::Int64)::Int64 
    count = 0
    for n1 in nums
        for n2 in nums
            count += (n1 + n2 == target)
        end
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3], 4) == 3)
end
