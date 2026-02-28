function f(text::String, prefix::String)::String 
    while startswith(text, prefix)
        text = text[length(prefix)+1:end]
        if text == ""
            break
        end
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("ndbtdabdahesyehu", "n") == "dbtdabdahesyehu")
end
