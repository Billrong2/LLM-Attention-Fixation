function f(text::String)::String 
    new_text = text
    while length(text) > 1 && text[1] == text[end]
        new_text = text = text[2:end-1]
    end
    return new_text
end
using Test

@testset begin

candidate = f;
	@test(candidate(")") == ")")
end
