function f(s::String, n::Int64)::String 
    if length(s) < n
        return s
    else
        return s[n+1:end]
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("try.", 5) == "try.")
end
