function f(text::String)::String 
    prefixes = ["acs", "asp", "scn"]
    for p in prefixes
        text = replace(text, p => "", count=1) * " "
    end
    return text[1:end-1]
end

using Test

@testset begin

candidate = f;
	@test(candidate("ilfdoirwirmtoibsac") == "ilfdoirwirmtoibsac  ")
end
