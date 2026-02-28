# 
sub f {
    my($letters) = @_;
    my @a;
    for(my $i = 0; $i < scalar(@$letters); $i++) {
        if(grep { $_ eq $letters->[$i] } @a) {
            return 'no';
        }
        push @a, $letters->[$i];
    }
    return 'yes';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["b", "i", "r", "o", "s", "j", "v", "p"]),"yes")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
