function f(test::String, sep::String, maxsplit::Int64)::Vector{String} 
    try
        return rsplit(test, sep, limit = maxsplit)
    catch
        return rsplit(test)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("ab cd", "x", 2) == ["ab cd"])
end
