function f(text::String)::String 
    new_text = collect(text)
    for i in 1:length(new_text)
        character = new_text[i]
        new_character = uppercase(character) == character ? lowercase(character) : uppercase(character)
        new_text[i] = new_character
    end
    return join(new_text, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("dst vavf n dmv dfvm gamcu dgcvb.") == "DST VAVF N DMV DFVM GAMCU DGCVB.")
end
