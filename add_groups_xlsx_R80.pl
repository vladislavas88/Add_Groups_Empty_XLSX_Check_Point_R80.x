#!/usr/bin/env perl

=pod

=head1 Using the script for create hosts for Check Point R80.x mgmt_cli
#===============================================================================
#
#         FILE: add_groups_xlsx_R80.pl 
#
#        USAGE: $ sudo dnf install perl-App-cpanminus
#        		$ cpanm Spreadsheet::ParseExcel Spreadsheet::XLSX Spreadsheet::Read
#
#               $./add_groups_xlsx_R80.pl in_groups.xlsx
#
#		$ cat ./add_groups_R80.txt'
#		  add group name "gr_Group_01" --version 1.3 --format json 
#		  add group name "gr_Group_02" --version 1.3 --format json
#		  add group name "gr_Group_03" --version 1.3 --format json
#		  add group name "gr_Group_04" --version 1.3 --format json
#
#  DESCRIPTION: Create hosts for Check Point R80.x mgmt_cli
#
#      OPTIONS: ---
# REQUIREMENTS: Perl v5.14+ 
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Vladislav Sapunov 
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 21.02.2024 22:22:08
#     REVISION: ---
#===============================================================================
=cut

use strict;
use warnings;
use v5.14;
use utf8;
use Spreadsheet::Read;

#use Data::Dumper; # for debug
my $inGroups = $ARGV[0];

# Source XLSX File with groups names
my $workbook = ReadData($inGroups) or die "Couldn't Open file " . "$!\n";
my $sheet = $workbook->[1];
my @column = ($sheet->{cell}[1]);

# Result outFile for mgmt_cli
my $outFile     = 'add_groups_R80.txt';
my $addGroupsName = "add group name";
my $version     = "--version 1.3";
my $format      = "--format json";

# Open result outFile for writing
open( FHW, '>', $outFile ) or die "Couldn't Open file $outFile" . "$!\n";

foreach my $row (@column) {
    for (@$row) {
		say FHW "$addGroupsName" . " " . "\"" . "$_" . "\"" . " " . "$version" . " " . "$format" if (defined);
	}
}

# Close the filehandle
close(FHW) or die "$!\n";

say "**********************************************************************************\n";
say "Host TXT file: $outFile created successfully!";

my $cpUsage = <<__USAGE__;

***************************************************************************************
* # Create the actual object
* > add group name "gr_Group_01" --version 1.3 --format json 
* > add group name "gr_Group_02" --version 1.3 --format json
* > add group name "gr_Group_03" --version 1.3 --format json
* > add group name "gr_Group_04" --version 1.3 --format json
* > add group name "gr_Group_05" --version 1.3 --format json
* > add group name "gr_Group_06" --version 1.3 --format json
* > add group name "gr_Group_07" --version 1.3 --format json
* > add group name "gr_Group_08" --version 1.3 --format json
* > add group name "gr_Group_09" --version 1.3 --format json
* > add group name "gr_Group_10" --version 1.3 --format json
* #				
***************************************************************************************

__USAGE__

say $cpUsage;

