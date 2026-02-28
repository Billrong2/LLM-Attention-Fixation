function f(d::Dict{Int64,Int64}, index::Int64)::Int64
    length_dict = length(d)
    if length_dict == 0
        error("Dictionary is empty")
    end
    idx = index % length_dict + 1
    keys_dict = collect(keys(d))
    k = keys_dict[idx]
    v = d[k]
    deleteat!(keys_dict, idx)
    for key in keys_dict
        if haskey(d, key)
            deleteat!(d, key)
        end
    end
    return v
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict(27 => 39), 1) == 39)
end
