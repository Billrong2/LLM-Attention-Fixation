function f(text::String, splitter::String)::String 
    return join(split(lowercase(text), " "), splitter)
end
using Test

@testset begin

candidate = f;
	@test(candidate("LlTHH sAfLAPkPhtsWP", "#") == "llthh#saflapkphtswp")
end
