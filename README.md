# rootsmagic-6levels
Insert 6levels facts into a RootsMagic database.

"6 levels" is a genealogy research concept from Yvette Hoitink:
https://www.dutchgenealogy.nl/six-levels-ancestral-profiles/
The 6 level values will be stored in the database as a custom fact; value 0 to 6.

These steps add the fact, at level 1, to everyone who does not have the fact. Then
upgrades to level 2, 3 or 4 based on other facts such as birth, death, census, marriage data/place, etc.
Because a level is never down graded the scripts can be repeated after new people are added or new
facts are added.

This code does not make use of level 0 (unknown name) due to no easy/consistant way to
describe someone with no name. And this code can't set levels 5 or 6 because those
are subjective.

The values for anyone's ancestor can be visualized via the Family Sunburst program (https://github.com/johnandrea/familytree-sunburst).

## Installation

Requires the SQLite command line interface and these .sql files.

The SQLite command line program is available in the appropriate "tools" download at: https://www.sqlite.org/download.html

## Options

None

## Usage

As always, try first on a temporary copy of a database or practise on those in the test directory.

First use the RootsMagic program to create a custom fact for someone, but leave it without data.
I use the name "6levels" and that name is used within the sql scripts. Exit RootsMagic.

Using the command line SQLite program.
```
$ sqlite3
sqlite> .open path-to-file/rootsmagic-database.rmtree
sqlite> .read step2-make-insert.sql
sqlite> .read step3-do-insert.sql
sqlite> .read step4-new-values.sql
sqlite> .q
```

Note that step2 creates the step3 file.

![create fact](adding-fact.jpg)
![run scripts](run-scripts.jpg)


## Details

The upgrading of levels operates like this:
- everyone with nothing goes to level 1
- upgrade 1 to 2 for birth / death / similar
- upgrade 1 to 2 for marriage record with date or place
- upgrade 2 to 3 for census
- upgrade 2 to 3 for family census
- upgrade 2 to 3 for known spouse
- upgrade 2 to 3 if children exist
- upgrade 3 to 4 if religion or immigration or naturalization or occupation or property or residence

## Bug reports

This code is provided with neither support nor warranty.
