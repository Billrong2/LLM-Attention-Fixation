function f(text::String, count::Int64)::String 
    for i in 1:count
        text = reverse(text)
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("aBc, ,SzY", 2) == "aBc, ,SzY")
end
