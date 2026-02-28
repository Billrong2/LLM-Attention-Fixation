function f(text::String)::String 
    text = replace(text, '#' => '1', '$' => '5')
    return occursin(r"^\d+$", text) ? "yes" : "no"
end
using Test

@testset begin

candidate = f;
	@test(candidate("A") == "no")
end
