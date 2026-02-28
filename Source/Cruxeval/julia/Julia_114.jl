function f(text::String, sep::String)::Vector{String} 
    return split(text, sep, limit=3)
end
using Test

@testset begin

candidate = f;
	@test(candidate("a-.-.b", "-.") == ["a", "", "b"])
end
