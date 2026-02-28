function f(text::String)::String 
    while occursin("nnet lloP", text)
        text = replace(text, "nnet lloP", "nnet loLp")
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("a_A_b_B3 ") == "a_A_b_B3 ")
end
