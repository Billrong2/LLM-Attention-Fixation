function f(text::String, a::String, b::String)::String 
    text = replace(text, a => b)
    return replace(text, b => a)
end
using Test

@testset begin

candidate = f;
	@test(candidate(" vup a zwwo oihee amuwuuw! ", "a", "u") == " vap a zwwo oihee amawaaw! ")
end
