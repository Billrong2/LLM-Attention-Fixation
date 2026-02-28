function f(text::String, substr::String, occ::Int64)::Int64 
    n = 0
    while true
        i = findlast(substr, text)
        if i === nothing
            break
        elseif n == occ
            return i.start - 1
        else
            n += 1
            text = text[1:i.start-1]
        end
    end
    return -1
end
using Test

@testset begin

candidate = f;
	@test(candidate("zjegiymjc", "j", 2) == -1)
end
