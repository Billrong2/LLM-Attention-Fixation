function f(text::String)::String 
    ans = ""
    while text != ""
        x, text = split(text, '(', limit=1)
        ans = x * "|" * ans
        ans = ans * text[1] * ans
        text = text[2:end]
    end
    return ans
end
using Test

@testset begin

candidate = f;
	@test(candidate("") == "")
end
