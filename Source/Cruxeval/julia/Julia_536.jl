function f(cat::String)::Int64 
    digits = 0
    for char in cat
        if isdigit(char)
            digits += 1
        end
    end
    return digits
end
using Test

@testset begin

candidate = f;
	@test(candidate("C24Bxxx982ab") == 5)
end
