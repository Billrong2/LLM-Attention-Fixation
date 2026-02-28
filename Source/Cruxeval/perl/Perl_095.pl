# 
sub f {
    my($zoo) = @_;
    my %zoo = %$zoo;
    my %flipped_zoo = reverse %zoo;
    return \%flipped_zoo;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"AAA" => "fr"}),{"fr" => "AAA"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
