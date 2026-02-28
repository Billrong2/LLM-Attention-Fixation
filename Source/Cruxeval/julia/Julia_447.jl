function f(text::String, tab_size::Int64)::String 
    res = ""
    text = replace(text, '\t' => repeat(' ', tab_size-1))
    for i in 1:length(text)
        if text[i] == ' '
            res *= '|'
        else
            res *= text[i]
        end
    end
    return res
end
using Test

@testset begin

candidate = f;
	@test(candidate("	a", 3) == "||a")
end
