function f(st::String)::String 
    swapped = ""
    for ch in reverse(st)
        swapped *= uppercase(ch) == ch ? lowercase(ch) : uppercase(ch)
    end
    return swapped
end
using Test

@testset begin

candidate = f;
	@test(candidate("RTiGM") == "mgItr")
end
