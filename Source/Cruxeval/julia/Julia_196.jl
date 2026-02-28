function f(text::String)::String 
    text = replace(text, " x" => " x.")
    if titlecase(text) == text
        return "correct"
    else
        text = replace(text, " x." => " x")
        return "mixed"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("398 Is A Poor Year To Sow") == "correct")
end
