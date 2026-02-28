function f(val::String, text::String)::Int64 
    indices = [index for index in 1:length(text) if text[index] == val]
    if length(indices) == 0
        return -1
    else
        return indices[1]
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("o", "fnmart") == -1)
end
