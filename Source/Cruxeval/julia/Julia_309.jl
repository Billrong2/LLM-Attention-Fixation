function f(text::String, suffix::String)::String 
    text *= suffix
    while text[end-length(suffix)+1:end] == suffix
        text = text[1:end-1]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("faqo osax f", "f") == "faqo osax ")
end
