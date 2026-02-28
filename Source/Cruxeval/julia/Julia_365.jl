function f(n::String, s::String)::String 
    if startswith(s, n)
        pre, _ = split(s, n, limit=1)
        return pre * n * s[length(n) + 1:end]
    end
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("xqc", "mRcwVqXsRDRb") == "mRcwVqXsRDRb")
end
