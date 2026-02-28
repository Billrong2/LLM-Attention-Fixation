function f(s::String, ch::String)::String 
    if !occursin(ch, s)
        return ""
    end
    s = reverse(split(s, ch)[2])
    for i in 1:length(s)
        s = reverse(split(s, ch)[2])
    end
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("shivajimonto6", "6") == "")
end
