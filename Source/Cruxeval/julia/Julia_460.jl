function f(text::String, amount::Int64)::String 
    length_text = length(text)
    pre_text = '|'
    if amount >= length_text
        extra_space = amount - length_text
        pre_text *= " " ^ div(extra_space, 2)
        return pre_text * text * pre_text
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("GENERAL NAGOOR", 5) == "GENERAL NAGOOR")
end
