-- create a script to insert new event entries
-- for everyone who doesn't already have it

-- This code is released under the MIT License: https://opensource.org/licenses/MIT
-- Copyright (c) 2024 John A. Andrea
-- v1.0

.headers off
.separator ""
.output step3-do-insert.sql

select 'insert into EventTable (Details,FamilyId,OwnerType,OwnerId,EventType) values (',
'1', ', ',
0, ', ',
0, ', ',
PersonID,', ',
(select FactTypeID from FactTypeTable where Name like'6levels'),
');'
from PersonTable
where PersonID not in
(select OwnerID from EventTable
  where EventType =
  (select FactTypeID from FactTypeTable where Name like'6levels')
)
;

.quit