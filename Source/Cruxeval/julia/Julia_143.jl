function f(s::String, n::String)::Bool 
    return lowercase(s) == lowercase(n)
end
using Test

@testset begin

candidate = f;
	@test(candidate("daaX", "daaX") == true)
end
