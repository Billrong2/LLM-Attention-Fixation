function f(x::String)::Bool 
    n = length(x)
    i = 1
    while i <= n && isdigit(x[i])
        i += 1
    end
    return i > n
end
using Test

@testset begin

candidate = f;
	@test(candidate("1") == true)
end
