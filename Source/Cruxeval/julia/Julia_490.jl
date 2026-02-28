function f(s::String)::String 
    return join([c for c in s if isspace(c)])
end
using Test

@testset begin

candidate = f;
	@test(candidate("
giyixjkvu
 rgjuo") == "

 ")
end
