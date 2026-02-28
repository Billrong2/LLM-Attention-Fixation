function f(text::String, n::Int64)::String 
    if length(text) <= 2
        return text
    end
    
    leading_chars = repeat(text[1], n - length(text) + 1)
    return leading_chars * text[2:end-1] * text[end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("g", 15) == "g")
end
