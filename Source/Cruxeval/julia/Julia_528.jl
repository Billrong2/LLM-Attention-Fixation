function f(s::String)::Int64
    b = ""
    c = ""
    for i in s
        c = string(c, i)
        if occursin(c, s)
            return findlast(c, s)[1] - 1
        end
    end
    return 0
end

using Test

@testset begin

candidate = f;
	@test(candidate("papeluchis") == 2)
end
