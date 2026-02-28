function f(num::Int64)::String 
    if 0 < num < 1000 && num != 6174
        return "Half Life"
    end
    return "Not found"
end
using Test

@testset begin

candidate = f;
	@test(candidate(6173) == "Not found")
end
