function f(names::String)::String 
    parts = split(names, ',')
    for (i, part) in enumerate(parts)
        parts[i] = replace(replace(titlecase(part), " And" => "+"), "+" => " and")
    end
    return join(parts, ", ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("carrot, banana, and strawberry") == "Carrot,  Banana,  and Strawberry")
end
