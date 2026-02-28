function f(text::String)::Int64 
    k = split(text, '\n')
    i = 0
    for j in k
        if length(j) == 0
            return i
        end
        i += 1
    end
    return -1
end
using Test

@testset begin

candidate = f;
	@test(candidate("2 m2 

bike") == 1)
end
