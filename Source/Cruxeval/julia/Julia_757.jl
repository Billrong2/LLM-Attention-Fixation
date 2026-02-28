function f(text::String, char::String, replacement::String)::String 
    return replace(text, char => replacement)
end

using Test

@testset begin

candidate = f;
	@test(candidate("a1a8", "1", "n2") == "an2a8")
end
