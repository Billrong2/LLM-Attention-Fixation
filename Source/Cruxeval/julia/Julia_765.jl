function f(text::String)::Int64 
    return sum(1 for c in text if isdigit(c))
end
using Test

@testset begin

candidate = f;
	@test(candidate("so456") == 3)
end
