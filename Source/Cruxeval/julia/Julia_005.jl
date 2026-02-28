function f(text::String, lower::String, upper::String)::Tuple{Int64, String} 
    count = 0
    new_text = []
    for char in text
        char = isdigit(char) ? lower : upper
        if char in ['p', 'C']
            count += 1
        end
        push!(new_text, char)
    end
    return count, join(new_text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("DSUWeqExTQdCMGpqur", "a", "x") == (0, "xxxxxxxxxxxxxxxxxx"))
end
