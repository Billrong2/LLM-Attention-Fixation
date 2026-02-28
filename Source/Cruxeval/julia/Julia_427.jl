function f(s::String)::String 
    count = length(s) - 1
    reverse_s = reverse(s)
    while count > 0 && occursin("sea", reverse_s[1:3:end]) == false
        count -= 1
        reverse_s = reverse_s[1:count]
    end
    return reverse_s[count + 1:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("s a a b s d s a a s a a") == "")
end
