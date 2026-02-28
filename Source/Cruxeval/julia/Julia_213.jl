function f(s::String)::String 
    s = replace(s, '(' => '[')
    s = replace(s, ')' => ']')
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("(ac)") == "[ac]")
end
