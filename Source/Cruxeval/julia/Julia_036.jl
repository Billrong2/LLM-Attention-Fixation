function f(text::String, chars::String)::String 
    chars = collect(chars)
    text = collect(text)
    for char in reverse(text)
        if char in chars
            poplast!(text)
        else
            break
        end
    end
    return String(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("ha", "") == "ha")
end
