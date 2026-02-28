using Base

function f(text::String)::String 
    words = split(text)
    for item in words
        text = replace(text, "-$item" => " ")
        text = replace(text, "$item-" => " ")
    end
    return strip(text, '-')
end
using Test

@testset begin

candidate = f;
	@test(candidate("-stew---corn-and-beans-in soup-.-") == "stew---corn-and-beans-in soup-.")
end
