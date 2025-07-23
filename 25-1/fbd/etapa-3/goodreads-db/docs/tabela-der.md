**1b) Tabela de correspondência entre projeto conceitual e lógico**

| TABELA | ELEMENTO DO DER |
| :---- | :---- |
| SERIES | Entidade Series |
| WORKS | Entidade Work |
| GENRES | Entidade Genre |
| AUTHORS | Entidade Author |
| EDITIONS | Entidade Edition, Relacionamento Publication (entre Work/Edition) |
| USERS | Entidade User |
| GROUPS | Entidade Group |
| LISTS | Entidade List |
| EDITION\_LISTENTRY | Entidade ListEntry (especialização da entidade Edition), Relacionamento Entry (entre ListEntry/List) |
| SHELVES | Entidade Shelf |
| QUOTES | Entidade Quote, Relacionamento Attribution (entre Quote/Author) |
| POSITIONINGS | Relacionamento Positioning (entre Series/Work) |
| CATEGORIZATIONS | Relacionamento Categorization (entre Work/Genre)  |
| AUTHORSHIPS | Relacionamento Authorship (entre Work/Author) |
| STORAGES | Relacionamento Storage (entre Edition/Shelf) |
| OWNERSHIPS | Relacionamento Ownership (entre Shelf/User) |
| TRACKINGS | Relacionamento Tracking (entre Edition/User) |
| LIKES | Relacionamento Like (entre Quote/User) |
| MEMBERSHIPS | Relacionamento Membership (entre User/Group) |
| MODERATIONS | Relacionamento Moderation (entre User/Group) |
| CURRENTLY\_READINGS | Relacionamento CurrentlyReading (entre Edition/Group) |
| VOTES | Relacionamento Vote (entre ListEntry/User) |

