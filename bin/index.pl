#!/usr/bin/env perl

# index.pl - make the corpus searchable

# Eric Lease Morgan <emorgan@nd.edu>
# September  9, 2019 - first repository deposit; just a place-holder
# September 10, 2019 - first running version


# configure
use constant DATABASE => './etc/bolivar.db';
use constant DRIVER   => 'SQLite';
use constant SOLR     => 'http://localhost:8983/solr/bolivar';
use constant QUERY    => 'SELECT * FROM documents ORDER BY filename;';
use constant FILTERED => './filtered';

# require
use DBI;
use strict;
use WebService::Solr;

# initialize
my $solr      = WebService::Solr->new( SOLR );
my $driver    = DRIVER; 
my $database  = DATABASE;
my $filtered  = FILTERED;
my $dbh       = DBI->connect( "DBI:$driver:dbname=$database", '', '', { RaiseError => 1 } ) or die $DBI::errstr;
binmode( STDOUT, ':utf8' );

# find all documents
my $handle = $dbh->prepare( QUERY );
$handle->execute() or die $DBI::errstr;

# process each document
while( my $document = $handle->fetchrow_hashref ) {
		
	# eliminate bogus records
	next if ( ! $$document{ 'filename' } );
	next if ( ! $$document{ 'year' } );
	
	# parse
	my $filename = $$document{ 'filename' };
	my $day      = $$document{ 'day' };
	my $month    = $$document{ 'month' };
	my $year     = $$document{ 'year' };
	my $type     = $$document{ 'type' };
	
	# get and normalize the full text
	my $fulltext = &slurp( "$filtered/$filename.txt" );
	$fulltext    =~ s/\r//g;
	$fulltext    =~ s/\n/ /g;
	$fulltext    =~ s/ +/ /g;
	$fulltext    =~ s/[^\x09\x0A\x0D\x20-\x{D7FF}\x{E000}-\x{FFFD}\x{10000}-\x{10FFFF}]//go;
		
	# debug; dump
	warn "        day: $day\n";
	warn "       type: $type\n";
	warn "       year: $year\n";
	warn "      month: $month\n";
	warn "   filename: $filename\n";
	warn "  full text: $fulltext\n";
	warn "\n";
		
	# initialize Solr data
	my $solr_day        = WebService::Solr::Field->new( 'day'        => $day );
	my $solr_facet_type = WebService::Solr::Field->new( 'facet_type' => $type );
	my $solr_filename   = WebService::Solr::Field->new( 'filename'   => $filename );
	my $solr_fulltext   = WebService::Solr::Field->new( 'fulltext'   => $fulltext );
	my $solr_month      = WebService::Solr::Field->new( 'month'      => $month );
	my $solr_type       = WebService::Solr::Field->new( 'type'       => $type );
	my $solr_year       = WebService::Solr::Field->new( 'year'       => $year );

	# fill a solr document with the fields
	my $doc = WebService::Solr::Document->new;
	$doc->add_fields( $solr_filename, $solr_day, $solr_month, $solr_year, $solr_type, $solr_fulltext, $solr_facet_type );

	# save/index
	$solr->add( $doc );

}

# done
exit;


sub slurp {

	my $f = shift;
	open ( F, $f ) or die "Can't open $f: $!\n";
	my $r = do { local $/; <F> };
	close F;
	return $r;

}