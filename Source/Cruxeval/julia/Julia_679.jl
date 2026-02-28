function f(text::String)::Bool 
    if text == ""
        return false
    end
    
    first_char = text[1]
    if isdigit(first_char)
        return false
    end
    
    for last_char in text
        if (last_char != '_') && !(last_char in ['a':'z'; 'A':'Z'; '0':'9'; '_'])
            return false
        end
    end
    
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("meet") == true)
end
