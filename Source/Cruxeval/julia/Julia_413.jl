function f(s::String)::String 
    return string(s[4:end], s[3], s[6:end])
end
using Test

@testset begin

candidate = f;
	@test(candidate("jbucwc") == "cwcuc")
end
