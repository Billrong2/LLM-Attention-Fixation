function f(s::String)::Int64
    return sum([isa(s, AbstractString) && isuppercase(first(s)) && all(islowercase, s[2:end]) for s in split(s)])
end
using Test

@testset begin

candidate = f;
	@test(candidate("SOME OF THIS Is uknowN!") == 1)
end
