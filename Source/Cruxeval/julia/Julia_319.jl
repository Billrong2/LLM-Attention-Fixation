function f(needle::String, haystack::String)::Int64 
    count = 0
    while occursin(needle, haystack)
        haystack = replace(haystack, needle => "", count=1)
        count += 1
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate("a", "xxxaaxaaxx") == 4)
end
