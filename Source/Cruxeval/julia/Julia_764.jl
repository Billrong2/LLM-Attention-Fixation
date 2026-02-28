function f(text::String, old::String, new::String)::String 
    text2 = replace(text, old => new)
    old2 = reverse(old)
    while occursin(old2, text2)
        text2 = replace(text2, old2 => new)
    end
    return text2
end
using Test

@testset begin

candidate = f;
	@test(candidate("some test string", "some", "any") == "any test string")
end
