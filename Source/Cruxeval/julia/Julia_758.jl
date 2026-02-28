function f(nums::Vector{Int64})::Bool 
    if nums == reverse(nums)
        return true
    end
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 3, 6, 2]) == false)
end
