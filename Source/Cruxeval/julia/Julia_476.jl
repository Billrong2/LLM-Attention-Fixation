function f(a::String, split_on::String)::Bool 
    t = split(a)
    a = []
    for i in t
        for j in i
            push!(a, j)
        end
    end
    if split_on in a
        return true
    else
        return false
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("booty boot-boot bootclass", "k") == false)
end
