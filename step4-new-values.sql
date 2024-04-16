-- update level data based on existing data

-- This code is released under the MIT License: https://opensource.org/licenses/MIT
-- Copyright (c) 2024 John A. Andrea
-- v1.1

-- heavy on the subselectes
-- appears that zero is used frequently instead of null, not sure if due to SQLite or RootsMagic

-- everyone with nothing goes to level 1
update EventTable set Details='1'
where Details like ''
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
;

-- upgrade 1 to 2 for birth / death
update EventTable set Details='2'
where Details like '1'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and OwnerId in
   (select OwnerId from EventTable
    where EventType in
       (select FactTypeId from FactTypeTable where GedcomTag in
           ('BIRT','DEAT','CHR','BAPM')
       )
   )
;

-- upgrade 1 to 2 for marriage record which needs detail
update EventTable set Details='2'
where Details like '1'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and (   OwnerId in (select FatherId from FamilyTable
                    where FamilyId in
                       (select OwnerId from EventTable
                        where OwnerType = 1
                        and ( Date <> 0 or PlaceId <> 0 )
                        and EventType in
                           (select FactTypeId from FactTypeTable
                              where GedcomTag in ('MARR','DIV')
                           )
                       )
                   )
     or OwnerId in (select MotherId from FamilyTable
                    where FamilyId in
                       (select OwnerId from EventTable
                        where OwnerType = 1
                        and ( Date <> 0 or PlaceId <> 0 )
                        and EventType in
                           (select FactTypeId from FactTypeTable
                              where GedcomTag in ('MARR','DIV')
                           )
                       )
                   )
    )
;


-- upgrade 2 to 3 for census
update EventTable set Details='3'
where Details like '2'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and OwnerId in
   (select OwnerId from EventTable
    where EventType in
       (select FactTypeId from FactTypeTable where GedcomTag in
            ('CENS')
        )
   )
;

-- upgrade 2 to 3 for family census
update EventTable set Details='3'
where Details like '2'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and OwnerId in
(select FatherID from FamilyTable where FamilyID in
   (select OwnerId from EventTable where EventType in
      (select FactTypeID from FactTypeTable where
         GedcomTag like 'CENS' and OwnerType=1
      )
   )
 union
 select MotherID from FamilyTable where FamilyID in
   (select OwnerId from EventTable where EventType in
      (select FactTypeID from FactTypeTable where
         GedcomTag like 'CENS' and OwnerType=1
      )
   )
);

-- upgrade 2 to 3 for known spouse
update EventTable set Details='3'
where Details like '2'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and (   OwnerId in (select FatherId from FamilyTable)
     or OwnerId in (select MotherId from FamilyTable)
    )
;

-- upgrade 2 to 3 if children
update EventTable set Details='3'
where Details like '2'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and (   OwnerId in (select FatherId from FamilyTable
                      where FamilyId in
                         (select FamilyId from ChildTable)
                    )
     or OwnerId in (select MotherId from FamilyTable
                      where FamilyId in
                         (select FamilyId from ChildTable)
                    )
    )
;


-- upgrade 3 to 4 if religion or immigration or naturalization or occupation or property or residence
update EventTable set Details='4'
where Details like '3'
and OwnerType = 0
and EventType=(select FactTypeID from FactTypeTable where Name like '6levels')
and OwnerId in
   (select OwnerId from EventTable
    where EventType in
       (select FactTypeId from FactTypeTable where GedcomTag in
            ('RELI','IMMI','NATU','OCCU','PROP','RESI')
       )
   )
;

.quit