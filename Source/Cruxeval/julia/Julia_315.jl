function f(challenge::String)::String 
    return replace(lowercase(challenge), "l" => ",")
end
using Test

@testset begin

candidate = f;
	@test(candidate("czywZ") == "czywz")
end
