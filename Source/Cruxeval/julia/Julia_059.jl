function f(s::String)::String 
    a = [char for char in s if char != ' ']
    b = copy(a)
    for c in reverse(a)
        if c == ' '
            pop!(b)
        else
            break
        end
    end
    return join(b, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("hi ") == "hi")
end
