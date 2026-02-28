function f(text::String)::String 
    new_text = []
    for character in text
        if isuppercase(character)
            insert!(new_text, length(new_text) ÷ 2 + 1, character)
        end
    end
    
    if isempty(new_text)
        new_text = ['-']
    end
    
    return join(new_text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("String matching is a big part of RexEx library.") == "RES")
end
