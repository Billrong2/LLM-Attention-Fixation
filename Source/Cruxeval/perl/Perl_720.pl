# 
sub f {
    my($items, $item) = @_;
    while ($items->[-1] eq $item) {
        pop @$items;
    }
    push @$items, $item;
    return scalar @$items;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["bfreratrrbdbzagbretaredtroefcoiqrrneaosf"], "n"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
