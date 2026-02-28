function f(text::String)::Vector{String} 
    text_arr = [text[j:end] for j in 1:length(text)]
    return text_arr
end
using Test

@testset begin

candidate = f;
	@test(candidate("123") == ["123", "23", "3"])
end
