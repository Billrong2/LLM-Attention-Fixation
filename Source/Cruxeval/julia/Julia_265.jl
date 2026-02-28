function f(d::Dict{Int64, Int64}, k::Int64)::Dict{Int64, Int64}
    new_d = Dict{Int64, Int64}()
    for (key, val) in d
        if key < k
            new_d[key] = val
        end
    end
    return new_d
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(1 => 2, 2 => 4, 3 => 3), 3) == Dict(1 => 2, 2 => 4))
end
