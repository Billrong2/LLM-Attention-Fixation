function f(book::String)::String 
    a = split(book, ':')
    if split(split(a[1], ' ')[1])[end] == split(split(a[2], ' ')[1])[1]
        return f(join(split(a[1], ' ')[1:end], ' ') * ' ' * split(a[2], ' ')[1])
    end
    return book
end
using Test

@testset begin

candidate = f;
	@test(candidate("udhv zcvi nhtnfyd :erwuyawa pun") == "udhv zcvi nhtnfyd :erwuyawa pun")
end
