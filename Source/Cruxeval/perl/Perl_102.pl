# 
sub f {
    my($names, $winners) = @_;
    my @ls;
    for my $name (@$names) {
        if (grep { $_ eq $name } @$winners) {
            push @ls, index($names, $name);
        }
    }
    @ls = sort { $b <=> $a } @ls;
    return \@ls;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["e", "f", "j", "x", "r", "k"], ["a", "v", "2", "im", "nb", "vj", "z"]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
