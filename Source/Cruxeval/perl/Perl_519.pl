# 
sub f {
    my($d) = @_;
    $d->{'luck'} = 42;
    %{$d} = ();
    return {1 => '', 2 => 1};
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{1 => "", 2 => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
