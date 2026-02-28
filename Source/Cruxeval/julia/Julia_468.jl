function f(a::String, b::String, n::Int64)::String 
    result = m = b
    for _ in 1:n
        if m != ""
            a, m = replace(a, m => "", count=1), ""
            result = m = b
        end
    end
    return join(split(a, b), result)
end
using Test

@testset begin

candidate = f;
	@test(candidate("unrndqafi", "c", 2) == "unrndqafi")
end
