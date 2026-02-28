function f(replace::String, text::String, hide::String)::String 
    while occursin(hide, text)
        replace *= "ax"
        text = replace(text, hide, replace, 1)
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("###", "ph>t#A#BiEcDefW#ON#iiNCU", ".") == "ph>t#A#BiEcDefW#ON#iiNCU")
end
