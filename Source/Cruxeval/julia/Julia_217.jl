function f(string::String)::String 
    if occursin(r"^[a-zA-Z0-9]*$", string)
        return "ascii encoded is allowed for this language"
    else
        return "more than ASCII"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("Str zahrnuje anglo-ameriæske vasi piscina and kuca!") == "more than ASCII")
end
