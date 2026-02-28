function f(text::String)::String
    odd = ""
    even = ""
    for (i, c) in enumerate(text)
        if (i - 1) % 2 == 0
            even *= c
        else
            odd *= c
        end
    end
    return even * lowercase(odd)
end

using Test

@testset begin

candidate = f;
	@test(candidate("Mammoth") == "Mmohamt")
end
