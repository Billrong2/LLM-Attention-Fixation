function f(text::String)::String 
    for i in reverse(1:length(text)-1)
        if !isuppercase(text[i])
            return text[1:i]
        end
    end
    return ""
end
using Test

@testset begin

candidate = f;
	@test(candidate("SzHjifnzog") == "SzHjifnzo")
end
