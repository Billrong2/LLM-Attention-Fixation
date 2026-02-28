function f(text::String)::String 
    if text != uppercase(text)
        return titlecase(text)
    end
    return lowercase(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("PermissioN is GRANTed") == "Permission Is Granted")
end
