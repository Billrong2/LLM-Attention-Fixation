function f(text::String)::Int64 
    a = [""]
    b = ""
    for i in text
        if !isspace(i)
            push!(a, b)
            b = ""
        else
            b *= i
        end
    end
    return length(a)
end
using Test

@testset begin

candidate = f;
	@test(candidate("       ") == 1)
end
