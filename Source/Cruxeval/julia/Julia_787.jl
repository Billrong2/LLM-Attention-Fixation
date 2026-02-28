function f(text::String)::String 
    if length(text) == 0
        return ""
    end
    text = lowercase(text)
    return uppercase(text[1]) * text[2:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("xzd") == "Xzd")
end
