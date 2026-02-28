function f(ets::Dict{Int64, Int64})::Dict{Int64, Int64}
    keys_to_process = collect(keys(ets))
    for k in keys_to_process
        v = delete!(ets, k)
        ets[k] = v^2
    end
    return ets
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{Int64, Int64}()) == Dict{Int64, Int64}())
end
