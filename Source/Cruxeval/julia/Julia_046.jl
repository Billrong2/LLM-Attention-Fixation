function f(l::Vector{String}, c::String)::String 
    return join(l, c)
end
using Test

@testset begin

candidate = f;
	@test(candidate(["many", "letters", "asvsz", "hello", "man"], "") == "manylettersasvszhelloman")
end
