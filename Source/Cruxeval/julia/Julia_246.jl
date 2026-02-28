function f(haystack::String, needle::String)::Int64 
    for i in reverse(first(findfirst(needle, haystack)):(findfirst(needle, haystack)[1]-1))
        if haystack[i:end] == needle
            return i
        end
    end
    return -1
end

using Test

@testset begin

candidate = f;
	@test(candidate("345gerghjehg", "345") == -1)
end
