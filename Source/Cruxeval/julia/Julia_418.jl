function f(s::String, p::String)::String 
    arr = split(s, p)
    part_one, part_two, part_three = length(arr[1]), length(p), length(arr[2])
    if part_one >= 2 && part_two <= 2 && part_three >= 2
        return string(reverse(arr[1]) * p * reverse(arr[2]) * "#")
    end
    return string(arr[1] * p * arr[2])
end
using Test

@testset begin

candidate = f;
	@test(candidate("qqqqq", "qqq") == "qqqqq")
end
