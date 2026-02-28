function f(num::String, l::Int64)::String 
    t = ""
    while l > length(num)
        t *= '0'
        l -= 1
    end
    return t * num
end
using Test

@testset begin

candidate = f;
	@test(candidate("1", 3) == "001")
end
