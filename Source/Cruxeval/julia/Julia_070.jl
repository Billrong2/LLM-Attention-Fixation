function f(x::String)::Int64 
    a = 0
    for i in split(x, ' ')
        a += length(i)*2
    end
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate("999893767522480") == 30)
end
