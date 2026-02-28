function f(text::String)::String 
    result = ""
    for i in 1:length(text)
        if i % 2 == 0
            result *= string(text[i])
        else
            result *= uppercase(text[i])
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("vsnlygltaw") == "VsNlYgLtAw")
end
