# rootsmagic-6levels
Insert 6levels facts into a RootsMagic database.

"6 levels" is a genealogy research concept from Yvette Hoitink:
https://www.dutchgenealogy.nl/six-levels-ancestral-profiles/
The 6 level values should be stored in the database as a custom fact; value 0 to 6.

These steps add the fact, at level 1, to everyone who does not have the fact. Then
upgrades to level 2, 3 or 4 based on other facts such as birth, death, census, marriage data/place, etc.
Because a level is never down graded the scripts can be repeated after new people are added or new
facts are added.

This code does not make use of level 0 (unknown name) due to no easy/consistant way to
describe someone with no name. And this code can't set levels 5 or 6 because those
are subjective.

## Installation

Requires the SQLite command line interface and these .sql files.

The SQLite command line program is available in the appropriate "tools" download at: https://www.sqlite.org/download.html

## Options

None

## Usage

...soon

## Bug reports

This code is provided with neither support nor warranty.
