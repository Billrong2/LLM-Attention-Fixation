# 
sub f {
    my($d) = @_;
    %{$d} = ();
    return $d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"a" => "3", "b" => "-1", "c" => "Dum"}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
