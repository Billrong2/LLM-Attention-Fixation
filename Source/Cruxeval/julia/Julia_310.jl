function f(strands::Vector{String})::String 
    subs = copy(strands)
    for i in eachindex(subs)
        for _ in 1:(length(subs[i]) ÷ 2)
            subs[i] = subs[i][end] * subs[i][2:end-1] * subs[i][1]
        end
    end
    return join(subs)
end
using Test

@testset begin

candidate = f;
	@test(candidate(["__", "1", ".", "0", "r0", "__", "a_j", "6", "__", "6"]) == "__1.00r__j_a6__6")
end
