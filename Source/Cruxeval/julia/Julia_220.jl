function f(text::String, m::Int64, n::Int64)::String 
    text = string(text, text[1:m], text[n+1:end])
    result = ""
    for i in n+1:length(text)-m
        result = string(text[i], result)
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("abcdefgabc", 1, 2) == "bagfedcacbagfedc")
end
