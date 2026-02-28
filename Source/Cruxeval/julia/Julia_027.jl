function f(w::String)::Bool 
    ls = collect(w)
    omw = ""
    while length(ls) > 0
        omw *= popfirst!(ls)
        if length(ls) * 2 > length(w)
            return w[length(ls) + 1:end] == omw
        end
    end
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate("flak") == false)
end
