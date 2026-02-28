function f(text::String)::String
    for i in 10:-1:1
        while startswith(text, string(i))
            text = text[length(string(i))+1:end]
        end
    end
    return text
end

using Test

@testset begin

candidate = f;
	@test(candidate("25000   \$") == "5000   \$")
end
