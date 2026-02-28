function f(letters::String)::Int64 
    count = 0
    for l in letters
        if isdigit(l)
            count += 1
        end
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate("dp ef1 gh2") == 2)
end
