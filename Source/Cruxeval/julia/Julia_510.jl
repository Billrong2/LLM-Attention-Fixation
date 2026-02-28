function f(a::Dict{Int64, String}, b::Int64, c::String, d::String, e::Union{Int64, Float64})::Union{String, Int64} 
    key = d
    if haskey(a, key)
        num = pop!(a, key)
    end
    if b > 3
        return join(c)
    else
        return num
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(7 => "ii5p", 1 => "o3Jwus", 3 => "lot9L", 2 => "04g", 9 => "Wjf", 8 => "5b", 0 => "te6", 5 => "flLO", 6 => "jq", 4 => "vfa0tW"), 4, "Wy", "Wy", 1.0) == "Wy")
end
