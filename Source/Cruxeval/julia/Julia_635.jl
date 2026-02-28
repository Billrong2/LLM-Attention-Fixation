function f(text::String)::Bool 
    valid_chars = ['-', '_', '+', '.', '/', ' ']
    text = uppercase(text)
    for char in text
        if !isletter(char) && char ∉ valid_chars
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW") == false)
end
