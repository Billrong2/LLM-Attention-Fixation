function f(text::String, chars::String)::String 
    chars = collect(chars)
    text = collect(text)
    new_text = text
    while length(new_text) > 0 && text != []
        if new_text[1] in chars
            new_text = new_text[2:end]
        else
            break 
        end
    end
    return join(new_text, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("asfdellos", "Ta") == "sfdellos")
end
