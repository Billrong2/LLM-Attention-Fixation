function f(text::String)::Int64 
    string_a, string_b = split(text, ',')
    return -(length(string_a) + length(string_b))
end
using Test

@testset begin

candidate = f;
	@test(candidate("dog,cat") == -6)
end
