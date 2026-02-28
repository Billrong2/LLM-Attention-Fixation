function f(text::String, strip_chars::String)::String 
    reversed_text = join(reverse(collect(text)))
    stripped_text = join(collect(lstrip(rstrip(reversed_text, [c for c in strip_chars]), [c for c in strip_chars])))
    return join(reverse(collect(stripped_text)))
end
using Test

@testset begin

candidate = f;
	@test(candidate("tcmfsmj", "cfj") == "tcmfsm")
end
