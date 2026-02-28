function f(text::String)::String 
    my_list = split(text)
    sort!(my_list, rev=true)
    return join(my_list, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("a loved") == "loved a")
end
