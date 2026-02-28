function f(text::String, delimiter::String)::String
    text = rsplit(text, delimiter, limit=2)
    return text[1] * text[2]
end
using Test

@testset begin

candidate = f;
	@test(candidate("xxjarczx", "x") == "xxjarcz")
end
