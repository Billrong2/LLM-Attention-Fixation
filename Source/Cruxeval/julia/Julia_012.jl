function f(s::String, x::String)::String 
    count = 0
    while startswith(s, x) && count < length(s) - length(x)
        s = s[length(x) + 1:end]
        count += length(x)
    end
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("If you want to live a happy life! Daniel", "Daniel") == "If you want to live a happy life! Daniel")
end
