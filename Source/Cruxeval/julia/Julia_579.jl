function f(text::String)::String 
    if titlecase(text) == text
        if length(text) > 1 && lowercase(text) != text
            return lowercase(text[1]) * text[2:end]
        end
    elseif isletter(text)
        return uppercase(text[1]) * text[2:end]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("") == "")
end
