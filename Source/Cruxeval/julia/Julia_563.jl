function f(text1::String, text2::String)::Int64 
    nums = []
    for i in 1:length(text2)
        push!(nums, count(ch -> ch == text2[i], text1))
    end
    return sum(nums)
end
using Test

@testset begin

candidate = f;
	@test(candidate("jivespdcxc", "sx") == 2)
end
