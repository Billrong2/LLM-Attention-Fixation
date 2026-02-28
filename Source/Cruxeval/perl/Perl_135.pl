# 
sub f {
    my() = @_;
    my %d = (
        'Russia' => [('Moscow', 'Russia'), ('Vladivostok', 'Russia')],
        'Kazakhstan' => [('Astana', 'Kazakhstan')],
    );
    return [keys %d];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(),["Russia", "Kazakhstan"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
