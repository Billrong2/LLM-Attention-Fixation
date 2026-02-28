function f(text::String, value::String)::String 
    return lpad(text, length(value), '?')
end
using Test

@testset begin

candidate = f;
	@test(candidate("!?", "") == "!?")
end
