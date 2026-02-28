function f(s::String)::String 
    return join([lowercase(c) for c in s])
end
using Test

@testset begin

candidate = f;
	@test(candidate("abcDEFGhIJ") == "abcdefghij")
end
