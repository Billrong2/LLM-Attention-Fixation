function f(txt::String)::Int64 
    coincidences = Dict{Char, Int}()
    for c in txt
        if haskey(coincidences, c)
            coincidences[c] += 1
        else
            coincidences[c] = 1
        end
    end
    return sum(values(coincidences))
end
using Test

@testset begin

candidate = f;
	@test(candidate("11 1 1") == 6)
end
