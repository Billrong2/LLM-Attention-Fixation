function f(text::String)::String 
    new_text = ""
    for ch in lowercase(strip(text))
        if isnumeric(ch) || ch in ['Ä', 'ä', 'Ï', 'ï', 'Ö', 'ö', 'Ü', 'ü']
            new_text *= ch
        end
    end
    return new_text
end
using Test

@testset begin

candidate = f;
	@test(candidate("") == "")
end
