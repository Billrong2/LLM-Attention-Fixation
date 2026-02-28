function f(letters::String, maxsplit::Int64)::String 
    split_letters = split(letters)
    return join(split_letters[max(1, end-maxsplit+1):end])
end
using Test

@testset begin

candidate = f;
	@test(candidate("elrts,SS ee", 6) == "elrts,SSee")
end
