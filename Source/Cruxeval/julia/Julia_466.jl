function f(text::String)::String 
    length_ = length(text)
    index = 0
    while index < length_ && isspace(text[index+1])
        index += 1
    end
    return text[index+1:index+5]
end
using Test

@testset begin

candidate = f;
	@test(candidate("-----	
	th
-----") == "-----")
end
