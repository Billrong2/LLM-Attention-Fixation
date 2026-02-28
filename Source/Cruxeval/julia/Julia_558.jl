function f(nums::Vector{Int64}, mos::Vector{Int64})::Bool 
    for num in mos
        index_num = findfirst(isequal(num), nums)
        splice!(nums, index_num)
    end
    sort!(nums)
    for num in mos
        push!(nums, num)
    end
    for i in 1:length(nums)-1
        if nums[i] > nums[i+1]
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 1, 2, 1, 4, 1], [1]) == false)
end
