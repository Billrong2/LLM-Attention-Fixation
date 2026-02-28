function f(text::String)::Int64 
    number = 0
    for t in text
        if isnumeric(t)
            number += 1
        end
    end
    return number
end
using Test

@testset begin

candidate = f;
	@test(candidate("Thisisastring") == 0)
end
