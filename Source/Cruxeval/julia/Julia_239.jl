function f(text::String, froms::String)::String 
    text = lstrip(text, Set(froms))
    text = rstrip(text, Set(froms))
    return text
end

using Test

@testset begin

candidate = f;
	@test(candidate("0 t 1cos ", "st 0	
  ") == "1co")
end
