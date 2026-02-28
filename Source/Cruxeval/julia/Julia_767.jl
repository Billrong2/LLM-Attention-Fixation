function f(text::String)::String 
    a = split(strip(text), ' ')
    for i in 1:length(a)
        if !occursin(r"[0-9]+", a[i])
            return "-"
        end
    end
    return join(a, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("d khqw whi fwi bbn 41") == "-")
end
