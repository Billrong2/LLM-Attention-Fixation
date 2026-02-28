function f(text::String)::String 
    result = ""
    i = length(text)
    while i >= 1
        c = text[i]
        if isletter(c)
            result *= c
        end
        i -= 1
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("102x0zoq") == "qozx")
end
