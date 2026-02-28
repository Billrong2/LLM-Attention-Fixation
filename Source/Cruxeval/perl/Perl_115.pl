# 
sub f {
    my($text) = @_;
    my @res = ();
    for my $ch (split //, $text) {
        if (ord($ch) == 61) {
            last;
        }
        if (ord($ch) == 0) {
            next;
        }
        push @res, ord($ch).'; ';
    }
    return 'b\''.join('', @res).'\'';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("os||agx5"),"b'111; 115; 124; 124; 97; 103; 120; 53; '")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
