function f(text::String, size::Int64)::String 
    counter = length(text)
    for i in 1:trunc(Int, size - size % 2)
        text = " " * text * " "
        counter += 2
        if counter >= size
            return text
        end
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("7", 10) == "     7     ")
end
