function f(numbers::String)::Int64 
    for i in 1:length(numbers)
        if count(x -> x == '3', numbers) > 1
            return i
        end
    end
    return -1
end
using Test

@testset begin

candidate = f;
	@test(candidate("23157") == -1)
end
