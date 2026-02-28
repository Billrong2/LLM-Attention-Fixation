function f(ip::String, n::Int64)::String 
    i = 0
    out = ""
    for c in ip
        if i == n
            out *= '\n'
            i = 0
        end
        i += 1
        out *= c
    end
    return out
end
using Test

@testset begin

candidate = f;
	@test(candidate("dskjs hjcdjnxhjicnn", 4) == "dskj
s hj
cdjn
xhji
cnn")
end
