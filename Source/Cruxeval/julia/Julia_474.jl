function f(txt::String, marker::Int64)::String 
    a = []
    lines = split(txt, '\n')
    for line in lines
        push!(a, rpad(lpad(line, div(marker - length(line), 2)), marker, ' '))
    end
    return join(a, '\n')
end
using Test

@testset begin

candidate = f;
	@test(candidate("#[)[]>[^e>
 8", -5) == "#[)[]>[^e>
 8")
end
