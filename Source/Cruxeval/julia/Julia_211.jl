function f(s::String)::Int64 
    count = 0
    for c in s
        if findlast(isequal(c), s) != findfirst(isequal(c), s)
            count += 1
        end
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate("abca dea ead") == 10)
end
