function f(commands::Vector{Dict{String, Int64}})::Dict{String, Int64}
    d = Dict{String, Int64}()
    for c in commands
        merge!(d, c)
    end
    return d
end
using Test

@testset begin

candidate = f;
	@test(candidate([Dict("brown" => 2), Dict("blue" => 5), Dict("bright" => 4)]) == Dict("brown" => 2, "blue" => 5, "bright" => 4))
end
