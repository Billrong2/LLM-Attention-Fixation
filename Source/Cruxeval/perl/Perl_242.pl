# 
sub f {
    my($book) = @_;
    my @a = split(':', $book, 2);
    my @words_before_last = split(' ', $a[0]);
    my @words_after_first = split(' ', $a[1]);
    
    if ($words_before_last[-1] eq $words_after_first[0]) {
        return f(join(' ', @words_before_last[0 .. $#words_before_last - 1]) . ' ' . $a[1]);
    }
    return $book;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("udhv zcvi nhtnfyd :erwuyawa pun"),"udhv zcvi nhtnfyd :erwuyawa pun")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
