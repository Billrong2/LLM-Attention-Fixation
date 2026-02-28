function f(x::String)::String 
    return join(reverse(collect(x)), " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("lert dna ndqmxohi3") == "3 i h o x m q d n   a n d   t r e l")
end
