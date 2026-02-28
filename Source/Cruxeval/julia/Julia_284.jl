function f(text::String, prefix::String)::String 
    idx = 1
    for letter in prefix
        if text[idx] != letter
            return nothing
        end
        idx += 1
    end
    return text[idx:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("bestest", "bestest") == "")
end
