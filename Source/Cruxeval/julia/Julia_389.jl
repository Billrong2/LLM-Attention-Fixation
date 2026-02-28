function f(total::Vector{String}, arg::String)::Vector{String}
    if typeof(arg) <: AbstractArray
        for e in arg
            append!(total, split(e, ""))
        end
    else
        append!(total, split(arg, ""))
    end
    return total
end
using Test

@testset begin

candidate = f;
	@test(candidate(["1", "2", "3"], "nammo") == ["1", "2", "3", "n", "a", "m", "m", "o"])
end
