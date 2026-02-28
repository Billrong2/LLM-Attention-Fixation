function f(text::String, char::String)::Bool
    return islowercase(char[1]) && text == lowercase(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("abc", "e") == true)
end
