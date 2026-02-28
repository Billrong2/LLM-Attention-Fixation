function f(text::String, sep::String, maxsplit::Int64)::String 
    splitted = split(text, sep)
    length_s = length(splitted)
    new_splitted = splitted[1:div(length_s,2)]
    reverse!(new_splitted)
    new_splitted = vcat(new_splitted, splitted[div(length_s,2)+1:end])
    return join(new_splitted, sep)
end
using Test

@testset begin

candidate = f;
	@test(candidate("ertubwi", "p", 5) == "ertubwi")
end
