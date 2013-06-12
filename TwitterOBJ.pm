package TwitterOBJ;
use strict;
use warnings;
use Net::Twitter;
use Net::Twitter::Search;
use feature 'say';
use PitInfo;

sub new {
	my $self = {};
	bless $self, shift;
	return $self;
}

sub init {
	my $self = shift;
	my $pit_account= shift;
	my ($consumer_key, $consumer_secret, $access_token, $access_token_secret);
	($consumer_key, $consumer_secret, $access_token, $access_token_secret)
		= PitInfo->pitinfo( 'default', $pit_account,
		$consumer_key, $consumer_secret, $access_token, $access_token_secret
	);
	my $nt = Net::Twitter->new(
		traits							=> [qw/OAuth API::RESTv1_1/],
 		consumer_key 				=> $consumer_key,
		consumer_secret			=> $consumer_secret,
		access_token				=> $access_token,
		access_token_secret	=> $access_token_secret,
		ssl 								=> 1,
	 );
	$self->{nt} = $nt;
	say 'initialized';
	return $self;
}

sub get {
	my ($self, $opt) = @_;
	my $method = $opt->{method};
	my $twopt = $opt->{twopt};
  return $self->search($twopt) if $method eq 'search';
	my $pit_account = $opt->{pit_account};
	$self->init($pit_account) unless defined $self->{nt};
	my $nt = $self->{nt};
	my $res = $nt->$method($twopt);
	return $res;
}

sub search {
	my $self = shift;
	my $twopt = shift;
	my $nts = Net::Twitter::Search->new;
	my $res = $nts->search($twopt);
	return $res;
}
1;

