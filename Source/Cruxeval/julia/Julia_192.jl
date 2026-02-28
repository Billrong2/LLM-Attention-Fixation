function f(text::String, suffix::String)::String 
    output = text
    while endswith(text, suffix)
        output = text[1:endof(text)-length(suffix)]
        text = output
    end
    return output
end
using Test

@testset begin

candidate = f;
	@test(candidate("!klcd!ma:ri", "!") == "!klcd!ma:ri")
end
