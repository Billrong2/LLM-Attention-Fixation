function f(s::String, c::String)::String 
    s = split(s, ' ')
    return c * "  " * join(reverse(s), "  ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("Hello There", "*") == "*  There  Hello")
end
