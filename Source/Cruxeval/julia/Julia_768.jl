function f(s::String, o::String)::String 
    if occursin(o, s)
        return s
    end
    return o * f(s, reverse(o[1:end-2]))
end
using Test

@testset begin

candidate = f;
	@test(candidate("abba", "bab") == "bababba")
end
