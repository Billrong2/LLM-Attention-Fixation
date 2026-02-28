function f(text::String, suffix::String)::String 
    if length(suffix) > 0 && length(text) > 0 && endswith(text, suffix)
        return chop(text, length(suffix))
    else
        return text
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("spider", "ed") == "spider")
end
