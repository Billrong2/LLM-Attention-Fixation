function f(text::String, width::Int64)::String 
    result = ""
    lines = split(text, '\n')
    for l in lines
        result *= l * " " ^ (width - length(l)) * "\n"
    end
    result = result[1:end-1]  # Remove the very last empty line
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("l
l", 2) == "l 
l ")
end
