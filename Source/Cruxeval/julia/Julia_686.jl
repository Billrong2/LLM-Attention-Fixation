function f(d::Dict{String, Int}, l::Vector{String})::Dict{String, Int}
    new_d = Dict{String, Int}()

    for k in l
        if haskey(d, k)
            new_d[k] = d[k]
        end
    end

    return copy(new_d)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("lorem ipsum" => 12, "dolor" => 23), ["lorem ipsum", "dolor"]) == Dict("lorem ipsum" => 12, "dolor" => 23))
end
