# 
sub f {
    my($d) = @_;
    my %r = (
        'c' => {%$d},
        'd' => {%$d}
    );
    return ($r{'c'} == $r{'d'}, $r{'c'} eq $r{'d'});
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"i" => "1", "love" => "parakeets"}),["", 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
