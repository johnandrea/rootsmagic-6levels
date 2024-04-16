-- who has the 6levels values

-- This code is released under the MIT License: https://opensource.org/licenses/MIT
-- Copyright (c) 2024 John A. Andrea
-- v1.0

.mode column
.headers on
.output existing-values.out

select
   NameTable.OwnerId,
   NameTable.Surname,
   NameTable.Given,
   EventTable.Details
from NameTable, EventTable
where NameTable.isPrimary
and EventTable.OwnerType = 0
and NameTable.OwnerId = EventTable.OwnerId
and EventTable.EventType =
(select FactTypeID from FactTypeTable where Name like '6levels')
order by NameTable.OwnerId
;

.quit
