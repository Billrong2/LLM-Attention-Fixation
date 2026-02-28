function f(s::String)::String 
    r = []
    for i in length(s):-1:1
        push!(r, s[i])
    end
    return join(r)
end
using Test

@testset begin

candidate = f;
	@test(candidate("crew") == "werc")
end
