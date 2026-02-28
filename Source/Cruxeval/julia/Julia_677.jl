function f(text::String, length::Int64)::String 
    length = length < 0 ? -length : length
    output = ""
    for idx in 1:length
        if text[idx % lastindex(text)] != ' '
            output *= text[idx % lastindex(text)]
        else
            break
        end
    end
    return output
end
using Test

@testset begin

candidate = f;
	@test(candidate("I got 1 and 0.", 5) == "I")
end
