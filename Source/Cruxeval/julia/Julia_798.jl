function f(text::String, pre::String)::String 
    if !startswith(text, pre)
        return text
    end
    return replace(text, pre => "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("@hihu@!", "@hihu") == "@!")
end
