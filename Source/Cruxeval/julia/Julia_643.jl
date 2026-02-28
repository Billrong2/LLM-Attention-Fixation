function f(text::String, suffix::String)::String 
    if endswith(text, suffix)
        text = text[1:end-1] * uppercase(text[end])
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("damdrodm", "m") == "damdrodM")
end
