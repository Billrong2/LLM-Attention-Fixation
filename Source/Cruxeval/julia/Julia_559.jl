function f(n::String)::String 
    n = string(n)
    return n[1] * "." * replace(n[2:end], '-' => '_')
end
using Test

@testset begin

candidate = f;
	@test(candidate("first-second-third") == "f.irst_second_third")
end
