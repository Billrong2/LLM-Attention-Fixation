function f(text::String)::String 
    s = lowercase(text)
    for i in 1:length(s)
        if s[i] == 'x'
            return "no"
        end
    end
    return isuppercase(text) ? "true" : "false"
end
using Test

@testset begin

candidate = f;
	@test(candidate("dEXE") == "no")
end
