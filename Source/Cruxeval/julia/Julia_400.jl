function f(multi_string::String)::String 
    cond_string = map(isascii, split(multi_string))
    if true in cond_string
        return join([x for x in split(multi_string) if isascii(x)], ", ")
    else
        return ""
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("I am hungry! eat food.") == "I, am, hungry!, eat, food.")
end
