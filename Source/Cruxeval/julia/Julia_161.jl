function f(text::String, value::String)::String 
    parts = split(text, value)
    left = parts[1]
    right = parts[2]
    return right * left
end
using Test

@testset begin

candidate = f;
	@test(candidate("difkj rinpx", "k") == "j rinpxdif")
end
