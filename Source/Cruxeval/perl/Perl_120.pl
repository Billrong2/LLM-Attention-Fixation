# 
sub f {
    my($countries) = @_;
    my %language_country;
    foreach my $country (keys %$countries) {
        my $language = $countries->{$country};
        if (not exists $language_country{$language}) {
            $language_country{$language} = [];
        }
        push @{$language_country{$language}}, $country;
    }
    return \%language_country;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
