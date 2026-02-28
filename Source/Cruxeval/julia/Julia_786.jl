function f(text::String, letter::String)::String 
    if occursin(letter, text)
        start = findfirst(letter, text)
        return text[start[1]+1:end] * text[1:start[1]]
    end
    return text
end

using Test

@testset begin

candidate = f;
	@test(candidate("19kefp7", "9") == "kefp719")
end
