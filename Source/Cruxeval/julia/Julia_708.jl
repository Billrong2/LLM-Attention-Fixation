function f(string::String)::String 
    l = collect(string)
    for i in reverse(1:length(l))
        if l[i] != ' '
            break
        end
        popat!(l, i)
    end
    return join(l, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("    jcmfxv     ") == "    jcmfxv")
end
