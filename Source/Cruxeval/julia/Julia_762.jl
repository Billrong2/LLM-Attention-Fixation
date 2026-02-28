function f(text::String)::String 
    text = lowercase(text)
    capitalize = uppercase(text[1]) * text[2:end]
    return text[1] * capitalize[2:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("this And cPanel") == "this and cpanel")
end
