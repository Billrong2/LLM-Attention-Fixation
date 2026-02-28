function f(s::String)::String 
    nums = join(filter(c -> isdigit(c), s))
    if nums == ""
        return "none"
    end
    nums_split = split(nums, ',')
    m = maximum([parse(Int, num) for num in nums_split])
    return string(m)
end
using Test

@testset begin

candidate = f;
	@test(candidate("01,001") == "1001")
end
