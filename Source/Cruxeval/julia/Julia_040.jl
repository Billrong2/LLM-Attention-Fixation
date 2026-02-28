function f(text::String)::String 
    return string(text, "#")
end
using Test

@testset begin

candidate = f;
	@test(candidate("the cow goes moo") == "the cow goes moo#")
end
