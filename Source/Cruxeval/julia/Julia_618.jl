function f(match::String, fill::String, n::Int64)::String
    return fill[1:min(n, end)] * match
end

using Test

@testset begin

candidate = f;
	@test(candidate("9", "8", 2) == "89")
end
