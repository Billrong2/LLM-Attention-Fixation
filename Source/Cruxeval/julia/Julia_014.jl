function f(s::String)::String 
    arr = reverse(collect(strip(s)))
    return join(arr, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("   OOP   ") == "POO")
end
