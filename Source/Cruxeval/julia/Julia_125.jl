function f(text::String, res::Int64)::String 
    for c in ['*', '\n', '"']
        text = replace(text, c => "!$res" )
    end
    if text[1] == '!'
        text = text[length(string(res))+1:end]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("\"Leap and the net will appear", 123) == "3Leap and the net will appear")
end
