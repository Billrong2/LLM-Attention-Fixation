function f(n::Int64, m::Int64, num::Int64)::Int64 
    x_list = collect(n:m)
    j = 0
    while true
        j = mod(j + num, length(x_list))
        if x_list[j+1] % 2 == 0
            return x_list[j+1]
        end
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(46, 48, 21) == 46)
end
