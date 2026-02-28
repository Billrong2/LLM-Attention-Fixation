function f(price::Float64, product::String)::Float64 
    inventory = ["olives", "key", "orange"]
    if !(product in inventory)
        return price
    else
        price *= 0.85
        filter!(x -> x != product, inventory)
    end
    return price
end
using Test

@testset begin

candidate = f;
	@test(candidate(8.5, "grapes") == 8.5)
end
