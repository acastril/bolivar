#!/usr/bin/env perl

# search.pl - command-line interface to search a solr instance

# Eric Lease Morgan <emorgan@nd.edu>
# September 9, 2019 - first repository deposit; just a place-holder


# configure
use constant FACETFIELD => ( 'facet_type' );
use constant SOLR       => 'http://localhost:8983/solr/bolivar';
use constant FILTERED   => './filtered';

# require
use strict;
use WebService::Solr;

# get input; sanity check
my $query  = $ARGV[ 0 ];
if ( ! $query ) { die "Usage: $0 <query>\n" }

# initialize
my $solr     = WebService::Solr->new( SOLR );
my $filtered = FILTERED;

# build the search options
my %search_options = ();
$search_options{ 'facet.field' } = [ FACETFIELD ];
$search_options{ 'facet' }       = 'true';

# search
my $response = $solr->search( "$query", \%search_options );

# build a list of type facets
my @facet_type = ();
my $type_facets = &get_facets( $response->facet_counts->{ facet_fields }->{ facet_type } );
foreach my $facet ( sort { $$type_facets{ $b } <=> $$type_facets{ $a } } keys %$type_facets ) { push @facet_type, $facet . ' (' . $$type_facets{ $facet } . ')'; }

# get the total number of hits
my $total = $response->content->{ 'response' }->{ 'numFound' };

# get number of hits returned
my @hits = $response->docs;

# start the output
print "Your search found $total item(s) and " . scalar( @hits ) . " item(s) are displayed.\n\n";
print '   type facets: ', join( '; ', @facet_type ), "\n\n";

# loop through each document
for my $doc ( $response->docs ) {

	# parse
	my $filename = $doc->value_for(  'filename' );
	my $day      = $doc->value_for(  'day' );
	my $month    = $doc->value_for(  'month' );
	my $year     = $doc->value_for(  'year' );
	my $type     = $doc->value_for(  'type' );
	
	# output
	print "$filename\n";
	print "  date: $day, $month $year\n";
	print "  type: $type\n";
	print "\n";

}

# done
exit;


# convert an array reference into a hash
sub get_facets {

	my $array_ref = shift;
	
	my %facets;
	my $i = 0;
	foreach ( @$array_ref ) {
	
		my $k = $array_ref->[ $i ]; $i++;
		my $v = $array_ref->[ $i ]; $i++;
		next if ( ! $v );
		$facets{ $k } = $v;
	 
	}
	
	return \%facets;
	
}

