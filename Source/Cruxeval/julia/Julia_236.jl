function f(array::Vector{String})::String
    if length(array) == 1
        return join(array)
    end
    result = collect(array)
    i = 0
    while i < length(array)-1
        for j in 1:2
            result[i*2+1] = array[i+1]
            i += 1
        end
    end
    return join(result)
end
using Test

@testset begin

candidate = f;
	@test(candidate(["ac8", "qk6", "9wg"]) == "ac8qk6qk6")
end
