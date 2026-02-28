function f(text::String, char::String)::String 
    return join(split(text, char), " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("a", "a") == " ")
end
