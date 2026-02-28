function f(text::String, letter::String)::String 
    if islowercase(letter[1])
        letter = uppercase(letter)
    end
    
    text = join([char == lowercase(letter[1]) ? letter : char for char in text])
    
    return uppercase(text[1]) * lowercase(text[2:end])
end
using Test

@testset begin

candidate = f;
	@test(candidate("E wrestled evil until upperfeat", "e") == "E wrestled evil until upperfeat")
end
