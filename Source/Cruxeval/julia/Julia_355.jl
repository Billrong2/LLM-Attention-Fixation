function f(text::String, prefix::String)::String 
    return text[length(prefix)+1:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("123x John z", "z") == "23x John z")
end
