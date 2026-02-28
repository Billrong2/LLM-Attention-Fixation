function f(full::String, part::String)::Int64
    length_part = length(part)
    index = findfirst(part, full)
    count = 0
    while index !== nothing
        full = full[index[2]:end]
        index = findfirst(part, full)
        count += 1
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate("hrsiajiajieihruejfhbrisvlmmy", "hr") == 2)
end
