function f(text::String, char::String)::String 
    char_index = findfirst(char, text)
    if isnothing(char_index)
        char_index = 0
    end
    result = vcat(collect(text[1:char_index-1]))
    result = vcat(result, collect(char), collect(text[char_index + length(char):end]))
    return join(result)
end
using Test

@testset begin

candidate = f;
	@test(candidate("llomnrpc", "x") == "xllomnrpc")
end
