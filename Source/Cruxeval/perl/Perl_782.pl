use POSIX qw(setlocale LC_ALL);
setlocale(LC_ALL, 'C.UTF-8');

sub f {
    my($input) = @_;
    for my $char (split //, $input) {
        if ($char eq uc $char) {
            return "";
        }
    }
    return 1;
}


use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a j c n x X k"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
