function f(a::String)::String 
    for _ in 1:10
        for j in 1:length(a)
            if a[j] != '#'
                a = a[j:end]
                break
            end
        end
        for j in 1:length(a)
            if a[end-j+1] != '#'
                break
            else
                a = a[1:end-j]
            end
        end
    end
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate("##fiu##nk#he###wumun##") == "fiu##nk#he###wumun")
end
