function f(text::String)::Bool 
    ls = collect(text)
    ls[1], ls[end] = uppercase(ls[end]), uppercase(ls[1])
    return join(ls) == titlecase(join(ls))
end
using Test

@testset begin

candidate = f;
	@test(candidate("Josh") == false)
end
