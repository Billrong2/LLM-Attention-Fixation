function f(string::String, c::String)::Bool 
    return endswith(string, c)
end
using Test

@testset begin

candidate = f;
	@test(candidate("wrsch)xjmb8", "c") == false)
end
