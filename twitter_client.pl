#!/usr/bin/perl
use strict;
use warnings;
use TwitterOBJ;
use feature 'say';
use utf8;
use Encode;
use DateTimeEasy 'datestr';
use feature 'say';

my $method = shift @ARGV;

my $word;
my $last_ct;

if ($method eq 'search' || $method eq's' ) {
	$word = shift @ARGV;
	$word = decode_utf8($word);
  $last_ct = shift @ARGV || 1;
}else{
  $last_ct = shift @ARGV || 1;
}

say "$method $word $last_ct";

unless ( $method =~ m/^(h|m|s|search|home_timeline|mentions)$/ ){
say 'usage: ./twitter_client.pl method (search word) num';
say "method is 'home_timeline' 'mention' 'search'";
say "h m s are method's alias";
say '1 num is get 15 tweets at a time';
say 'ex) ./twitter_client.pl h 2';
say encode_utf8('ex) ./twitter_client.pl search 地震 3');
die;
}


die if $last_ct <= 0;

$method = 'search' if $method eq 's';
$method = 'home_timeline' if $method eq 'h';
$method = 'mentions' if $method eq 'm';

$method eq 'search'? say "$method $word: $last_ct times": say "method $method: $last_ct times"; 


my @contents;
my $max_id;

my $tw = TwitterOBJ->new;
$tw->init('toshi.private');

for (my $ct = 1; $ct <= $last_ct; ++$ct) {
	my $opt;
	if ($max_id ) {
		if ( $method eq 'search') {
			$opt = {
				method => 'search',
				twopt => {
					q => $word,
					max_id => $max_id,
				},
			};
		}else{
			$opt = {
				method => $method,
				twopt => {
					max_id => $max_id,
				},
			};
		}
	}else{ 
		if ( $method eq 'search') {
			$opt = {
				method => 'search',
				twopt => {
					q => $word,
				},
			};
		}else{
			$opt = {
				method => $method,
				twopt => {},
			};
		}
	}

	my $res =  $tw->get($opt);
	
	if ($method eq 'search' ){
		for (@{$res->{results}}) {
			my $content = {};
			$content->{text} = $_->{text};
			$content->{screen_name} = $_->{from_user};
			$content->{created_at} = $_->{created_at};
			push @contents, $content;
			$max_id = $_->{id};
		}
	}else{
		for (@{$res}) {
			my $content = {};
			$content->{text} = $_->{text};
			$content->{screen_name} = $_->{user}->{screen_name};
			$content->{created_at} = $_->{created_at};
			push @contents, $content;
			$max_id = $_->{id};
		}
	}
	$max_id = $max_id -1;
}

my $num = 0;

for (@contents) {
	my $text = encode_utf8($_->{text});
	my $screen_name = $_->{screen_name};
	my $date = datestr($_->{created_at},'standard');
 say "$num:$date: $screen_name:  $text";
 ++$num;
}







