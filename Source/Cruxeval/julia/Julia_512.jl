function f(s::String)::Bool 
    return length(s) == count(x -> x == '0' || x == '1', s)
end
using Test

@testset begin

candidate = f;
	@test(candidate("102") == false)
end
