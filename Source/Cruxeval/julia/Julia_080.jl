function f(s::String)::String 
    return string(reverse(rstrip(s)))
end
using Test

@testset begin

candidate = f;
	@test(candidate("ab        ") == "ba")
end
