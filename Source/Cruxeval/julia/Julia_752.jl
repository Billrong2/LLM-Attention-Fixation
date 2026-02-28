function f(s::String, amount::Int64)::String 
    return repeat('z', max(amount - length(s), 0)) * s
end
using Test

@testset begin

candidate = f;
	@test(candidate("abc", 8) == "zzzzzabc")
end
