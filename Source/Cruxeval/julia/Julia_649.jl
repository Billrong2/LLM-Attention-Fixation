function f(text::String, tabsize::Int64)::String 
    return join([replace(t, "\t" => " " ^ tabsize) for t in split(text, "\n")], "\n")
end
using Test

@testset begin

candidate = f;
	@test(candidate("	f9
	ldf9
	adf9!
	f9?", 1) == " f9
 ldf9
 adf9!
 f9?")
end
