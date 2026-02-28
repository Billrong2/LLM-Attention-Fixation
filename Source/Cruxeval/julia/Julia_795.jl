function f(text::String)::String 
    return replace(titlecase(text), "Io" => "io")
end
using Test

@testset begin

candidate = f;
	@test(candidate("Fu,ux zfujijabji pfu.") == "Fu,Ux Zfujijabji Pfu.")
end
