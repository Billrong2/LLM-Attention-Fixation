function f(values::Vector{String}, value::Int64)::Dict{String, Int64}
    length_values = length(values)
    new_dict = Dict{String, Int64}()
    for val in values
        new_dict[val] = value
    end
    sorted_values = join(sort(values))
    new_dict[sorted_values] = value * 3
    return new_dict
end
using Test

@testset begin

candidate = f;
	@test(candidate(["0", "3"], 117) == Dict("0" => 117, "3" => 117, "03" => 351))
end
