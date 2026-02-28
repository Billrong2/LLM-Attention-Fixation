function f(numbers::Vector{String}, prefix::String)::Vector{String} 
    return sort([length(n) > length(prefix) && startswith(n, prefix) ? n[length(prefix)+1:end] : n for n in numbers])
end
using Test

@testset begin

candidate = f;
	@test(candidate(["ix", "dxh", "snegi", "wiubvu"], "") == ["dxh", "ix", "snegi", "wiubvu"])
end
