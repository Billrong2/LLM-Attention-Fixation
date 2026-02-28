function f(prefix::String, text::String)::String 
    if startswith(text, prefix)
        return text
    else
        return prefix * text
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("mjs", "mjqwmjsqjwisojqwiso") == "mjsmjqwmjsqjwisojqwiso")
end
