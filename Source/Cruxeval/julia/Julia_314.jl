function f(text::String)::String 
    if occursin(",", text)
        before, after = split(text, ",", limit=2)
        return after * " " * before
    end
    return ", " * split(text, " ")[end] * " 0"
end
using Test

@testset begin

candidate = f;
	@test(candidate("244, 105, -90") == " 105, -90 244")
end
