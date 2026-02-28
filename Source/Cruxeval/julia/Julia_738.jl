function f(text::String, characters::String)::String 
    for i in 1:length(characters)
        text = rstrip(text, characters[i])
    end
    return text
end

using Test

@testset begin

candidate = f;
	@test(candidate("r;r;r;r;r;r;r;r;r", "x.r") == "r;r;r;r;r;r;r;r;")
end
