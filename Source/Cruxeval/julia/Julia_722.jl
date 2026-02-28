function f(text::String)::String 
    out = ""
    for i in 1:length(text)
        if isuppercase(text[i])
            out *= lowercase(text[i])
        else
            out *= uppercase(text[i])
        end
    end
    return out
end
using Test

@testset begin

candidate = f;
	@test(candidate(",wPzPppdl/") == ",WpZpPPDL/")
end
