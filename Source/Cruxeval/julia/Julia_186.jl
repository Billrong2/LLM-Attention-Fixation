function f(text::String)::String 
    words = split(text)
    stripped_words = map(word -> lstrip(word), words)
    return join(stripped_words, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("pvtso") == "pvtso")
end
