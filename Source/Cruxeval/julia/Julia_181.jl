function f(s::String)::Tuple{String, Int64} 
    count = 0
    digits = ""
    for c in s
        if isdigit(c)
            count += 1
            digits *= string(c)
        end
    end
    return (digits, count)
end
using Test

@testset begin

candidate = f;
	@test(candidate("qwfasgahh329kn12a23") == ("3291223", 7))
end
