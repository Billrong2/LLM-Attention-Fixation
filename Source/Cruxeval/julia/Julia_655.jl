function f(s::String)::String 
    s = replace(s, 'a' => "")
    s = replace(s, 'r' => "")
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("rpaar") == "p")
end
