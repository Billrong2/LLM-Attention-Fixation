function f(text::String, n::Int64)::String 
    length_text = length(text)
    return text[length_text*(n%4)+1:length_text]
end
using Test

@testset begin

candidate = f;
	@test(candidate("abc", 1) == "")
end
