function f(s1::String, s2::String)::String 
    if endswith(s2, s1)
        s2 = s2[1:endof(s2)-length(s1)]
    end
    return s2
end
using Test

@testset begin

candidate = f;
	@test(candidate("he", "hello") == "hello")
end
