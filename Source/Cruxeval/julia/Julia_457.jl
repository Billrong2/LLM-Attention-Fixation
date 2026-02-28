function f(nums::Vector{Int64})::Vector{Int64} 
    count = collect(1:length(nums))
    for i in 1:length(nums)
        pop!(nums)
        if length(count) > 0
            popfirst!(count)
        end
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 1, 7, 5, 6]) == Vector{Int64}([]))
end
