function f(text::String, ch::String)::String 
    result = String[]
    lines = split(text, '\n')
    for line in lines
        if length(line) > 0 && line[1] == ch[1]
            push!(result, lowercase(line))
        else
            push!(result, uppercase(line))
        end
    end
    return join(result, '\n')
end
using Test

@testset begin

candidate = f;
	@test(candidate("t
za
a", "t") == "t
ZA
A")
end
