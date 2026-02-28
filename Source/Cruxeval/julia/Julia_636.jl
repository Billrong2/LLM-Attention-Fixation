function f(d::Dict{Int64, String})::Dict{Int64, String}
    r = Dict{Int64, String}()
    while !isempty(d)
        r = merge(r, d)
        delete!(d, maximum(keys(d)))
    end
    return r
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(3 => "A3", 1 => "A1", 2 => "A2")) == Dict(3 => "A3", 1 => "A1", 2 => "A2"))
end
