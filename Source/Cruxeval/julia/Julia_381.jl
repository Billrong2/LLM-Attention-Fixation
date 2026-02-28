function f(text::String, num_digits::Int64)::String 
    width = max(1, num_digits)
    return lpad(text, width, '0')
end
using Test

@testset begin

candidate = f;
	@test(candidate("19", 5) == "00019")
end
