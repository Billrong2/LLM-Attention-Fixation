function f(test_str::String)::String 
    s = replace(test_str, 'a' => 'A')
    return replace(s, 'e' => 'A')
end
using Test

@testset begin

candidate = f;
	@test(candidate("papera") == "pApArA")
end
