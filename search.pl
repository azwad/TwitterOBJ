#!/usr/bin/perl
use strict;
use warnings;
use TwitterOBJ;
use URI::Escape;
use feature 'say';
use utf8;
use Encode;

my $tw = TwitterOBJ->new;

my $word = shift @ARGV;
$word = decode_utf8($word);
$word = uri_escape_utf8($word);

my $last_ct = shift @ARGV || 1;
#$last_ct = $last_ct -1;

die if $last_ct < 0;

my @result;
my $max_id = 0;
say "search word: $word last ct: $last_ct  max id: $max_id";

for (my $ct = 0; $ct <= $last_ct; ++$ct) {
	my $opt;
	if ($max_id ) {
		say "set max id $max_id";
		$opt = {
			method => 'search',
			twopt => {
				pit_account => 'toshi.private',
				q => $word,
				max_id => $max_id,
			},
		};
	}else{
		say "max_id is not set"; 
		$opt = {
			pit_account => 'toshi.private',
			method => 'search',
			twopt => {
				q => $word,
			},
		};
	}

	my $res =  $tw->get($opt);

	for (@{$res->{statuses}}) {
		my $text = $_->{text};
		say $text;
		push @result, $text;
		$max_id = $_->{id};
		say "max id:$max_id";
	}
	$max_id = $max_id -1;
}

my $num = 0;

for (@result) {
	my $text = encode_utf8($_);
 say "$num: $text";
 ++$num;
}



