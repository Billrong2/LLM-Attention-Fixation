function f(s::String, n::Int64, c::String)::String 
    width = length(c) * n
    while length(s) < width
        s = string(c, s)
    end
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate(".", 0, "99") == ".")
end
