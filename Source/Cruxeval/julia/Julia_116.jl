function f(d::Dict{Int64, Int64}, count::Int64)::Dict{Int64, Int64}
    for i in 1:count
        if isempty(d)
            break
        end
        delete!(d, first(keys(d)))
    end
    return d
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{Int64, Int64}(), 200) == Dict{Int64, Int64}())
end
