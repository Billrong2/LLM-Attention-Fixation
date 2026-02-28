function f(text::String)::String 
    if occursin(r"\d+", text)
        return "yes"
    else
        return "no"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("abc") == "no")
end
