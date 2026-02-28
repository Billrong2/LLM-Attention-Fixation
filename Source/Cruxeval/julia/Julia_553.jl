function f(text::String, count::Int64)::String 
    for i in 1:count
        text = reverse(text)
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("439m2670hlsw", 3) == "wslh0762m934")
end
