function f(text::String)::Int64 
    return count(occursin("#", split(text,':')[1]))
end
using Test

@testset begin

candidate = f;
	@test(candidate("#! : #!") == 1)
end
