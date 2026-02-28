function f(text::String)::Tuple{Int64, Int64} 
    ws = 0
    for s in text
        if isspace(s)
            ws += 1
        end
    end
    return ws, length(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("jcle oq wsnibktxpiozyxmopqkfnrfjds") == (2, 34))
end
