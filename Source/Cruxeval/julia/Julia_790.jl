function f(d::Dict{String, String})::Tuple{Bool, Bool} 
    r = Dict{String, Dict{String, String}}()
    r["c"] = copy(d)
    r["d"] = copy(d)
    return (r["c"] === r["d"], r["c"] == r["d"])
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("i" => "1", "love" => "parakeets")) == (false, true))
end
