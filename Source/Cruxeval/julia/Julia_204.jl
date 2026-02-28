function f(name::String)::Vector{String} 
    return [string(name[1]), string(name[2])[end:-1:1]]
end
using Test

@testset begin

candidate = f;
	@test(candidate("master. ") == ["m", "a"])
end
