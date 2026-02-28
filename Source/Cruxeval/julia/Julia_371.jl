function f(nums::Vector{Int64})::Int64 
    for odd in copy(nums)
        if odd % 2 != 0
            deleteat!(nums, findall(x->x==odd, nums))
        end
    end
    
    sum_ = 0
    for num in nums
        sum_ += num
    end
    return sum_
end
using Test

@testset begin

candidate = f;
	@test(candidate([11, 21, 0, 11]) == 0)
end
