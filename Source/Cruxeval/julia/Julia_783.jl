function f(text::String, comparison::String)::Int64 
    length_c = length(comparison)
    if length_c <= length(text)
        for i in 1:length_c
            if comparison[length_c - i + 1] != text[length(text) - i + 1]
                return i - 1
            end
        end
    end
    return length_c
end
using Test

@testset begin

candidate = f;
	@test(candidate("managed", "") == 0)
end
