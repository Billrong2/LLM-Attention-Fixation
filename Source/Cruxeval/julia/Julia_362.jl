using Unicode

function f(text::String)::String 
    for i in 1:length(text)-1
        if all(islowercase, text[i:end])
            return text[i+1:end]
        end
    end
    return ""
end
using Test

@testset begin

candidate = f;
	@test(candidate("wrazugizoernmgzu") == "razugizoernmgzu")
end
