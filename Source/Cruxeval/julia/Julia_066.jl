function f(text::String, prefix::String)::String 
    prefix_length = length(prefix)
    if startswith(text, prefix)
        return text[(prefix_length + 1) ÷ 2: (prefix_length - 1) ÷ 2]
    else
        return text
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("happy", "ha") == "")
end
