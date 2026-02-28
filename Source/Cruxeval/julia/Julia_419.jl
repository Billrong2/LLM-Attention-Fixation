function f(text::String, value::String)::String 
    if !(occursin(value, text))
        return ""
    end
    parts = split(text, value)
    return parts[1]
end
using Test

@testset begin

candidate = f;
	@test(candidate("mmfbifen", "i") == "mmfb")
end
