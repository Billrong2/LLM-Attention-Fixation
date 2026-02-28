function f(text::String, tabstop::Int64)::String 
    text = replace(text, '\n' => "_____")
    text = replace(text, '\t' => " " ^ tabstop)
    text = replace(text, "_____" => '\n')
    
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("odes	code	well", 2) == "odes  code  well")
end
