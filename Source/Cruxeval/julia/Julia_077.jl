function f(text::String, character::String)::String
    last_index = findlast(character, text)
    if last_index != nothing
        subject = text[last_index:end]
        return subject^count(character, text)
    else
        return ""
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("h ,lpvvkohh,u", "i") == "")
end
