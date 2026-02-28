function f(text::String, separator::Int64)::Vector{String} 
    splitted = split(text, '\n')
    if separator != 0
        return [join(s, ' ') for s in splitted]
    else
        return splitted
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("dga nqdkull qcha kl", 1) == ["d g a   n q d k", "u l l   q c h a   k l"])
end
