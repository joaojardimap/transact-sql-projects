# MusicStore Database Management (T-SQL)

This project implements the backend logic for a **MusicStore** application using **Transact-SQL (T-SQL)**. It acts as a Database Abstraction Layer, featuring 13 stored procedures designed to automate data integrity, handle complex many-to-many relationships, and orchestrate secure user onboarding via transactional scopes.

## Key Technical Highlights

### 1. Transactional Profile Creation (ACID Compliance)
The most complex feature is the **User Registration Pipeline** found in `profile_procedure.sql`.
I implemented a single **Transactional Procedure** (`Create_Full_Profile`) that orchestrates inserts across 4 different tables.

* **Atomic Operation:** It creates the Person, Address, Phone, and Security Question in a single execution block.
* **Rollback Safety:** Uses `BEGIN TRAN` and `COMMIT TRAN`. If any part of the profile fails, the entire operation is rolled back to prevent "orphan records".

```text
[ EXEC Create_Full_Profile ]
       |
       v
[ BEGIN TRANSACTION ]
       |
       +--> 1. Insert Person (Get Scope Identity ID)
       |        |
       +--> 2. Insert Address (Use ID from step 1)
       |        |
       +--> 3. Insert Phone
       |        |
       +--> 4. Insert Secret Question
       |
[ COMMIT TRANSACTION ] (Data is saved only if ALL steps succeed)
