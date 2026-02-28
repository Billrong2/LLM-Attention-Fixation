function f(text::String)::String 
    a = split(text, '\n')
    b = []
    for i in 1:length(a)
        c = replace(a[i], '\t' => "    ")
        push!(b, c)
    end
    return join(b, '\n')
end
using Test

@testset begin

candidate = f;
	@test(candidate("			tab tab tabulates") == "            tab tab tabulates")
end
