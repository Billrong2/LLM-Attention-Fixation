function f(n::String)::Int64 
    for i in n
        if !isdigit(Char(i))
            n = "-1"
            break
        end
    end
    return parse(Int64, n)
end
using Test

@testset begin

candidate = f;
	@test(candidate("6 ** 2") == -1)
end
