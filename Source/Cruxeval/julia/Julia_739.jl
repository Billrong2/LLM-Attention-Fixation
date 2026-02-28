function f(st::String, pattern::Vector{String})::Bool 
    for p in pattern
        if !startswith(st, p)
            return false
        end
        st = st[length(p)+1:end]
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("qwbnjrxs", ["jr", "b", "r", "qw"]) == false)
end
