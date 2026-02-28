function f(text::String)::String 
    result = ""
    for char in text
        if isletter(char) || isdigit(char)
            result *= uppercase(char)
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("с bishop.Swift") == "СBISHOPSWIFT")
end
