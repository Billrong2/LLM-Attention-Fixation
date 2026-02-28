function f(n::String)::String 
    if occursin(".", n) != 0
        return string(parse(Int, n) + 2.5)
    end
    return n
end
using Test

@testset begin

candidate = f;
	@test(candidate("800") == "800")
end
