function f(text::String)::Int64 
    counter = 0
    for char in text
        if isletter(char)
            counter += 1
        end
    end
    return counter
end
using Test

@testset begin

candidate = f;
	@test(candidate("l000*") == 1)
end
