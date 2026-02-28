function f(text::String, suffix::String)::String
    if !isempty(suffix) && last(suffix) in text
        return f(String(rstrip(text, last(suffix))), suffix[1:end-1])
    else
        return text
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("rpyttc", "cyt") == "rpytt")
end
