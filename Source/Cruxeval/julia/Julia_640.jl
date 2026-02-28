function f(text::String)::Int64 
    a = 0
    if text[1] ∈ text[2:end]
        a += 1
    end
    for i in 1:length(text)-1
        if text[i] ∈ text[i+1:end]
            a += 1
        end
    end
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate("3eeeeeeoopppppppw14film3oee3") == 18)
end
