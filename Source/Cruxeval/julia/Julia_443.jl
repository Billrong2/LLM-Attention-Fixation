function f(text::String)::String 
    for space in text
        if space == ' '
            text = strip(text)
        else
            text = replace(text, "cd" => string(space))
        end
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("lorem ipsum") == "lorem ipsum")
end
