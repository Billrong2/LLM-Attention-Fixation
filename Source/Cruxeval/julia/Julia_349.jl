function f(dictionary::Dict{String, Int64})::Dict{String, Int64}
    dictionary["1049"] = 55
    return dictionary
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("noeohqhk" => 623)) == Dict("noeohqhk" => 623, "1049" => 55))
end
