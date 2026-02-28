function f(text::String)::String 
    nums = filter(c -> isnumeric(c), text)
    nums = collect(nums)
    @assert length(nums) > 0
    return join(nums, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("-123   	+314") == "123314")
end
