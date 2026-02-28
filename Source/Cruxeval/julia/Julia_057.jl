function f(text::String)::Int64 
    text = uppercase(text)
    count_upper = 0
    for char in text
        if isuppercase(char)
            count_upper += 1
        else
            return "no"
        end
    end
    return count_upper ÷ 2
end
using Test

@testset begin

candidate = f;
	@test(candidate("ax") == 1)
end
