function f(text::String, prefix::String)::String 
    if startswith(text, prefix)
        text = replace(text, prefix => "")
    end
    text = uppercase(text[1]) * lowercase(text[2:end])
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("qdhstudentamxupuihbuztn", "jdm") == "Qdhstudentamxupuihbuztn")
end
