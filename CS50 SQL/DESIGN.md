# Design Document

By Samandar Abdullaev

Video overview: <https://youtu.be/VTpatxylt78>

## Scope
The database for Game Club Booking project includes all entities necessary to facilitate the process of tracking club information and leaving feedback on club work. As such, included in the database's scope is:
* Users, including basic identifying information
* Clubs, including basic identifying information
* Availabilities, including the time at which the club is open, the price, and the club to which the availability is related
* Addresses, which includes information about the club address
* Payments, which includes information about the user's card
* Reviews from users, including the content of the comment and the club on which the comment was left

Out of scope are elements like analytics, security measurements, and other non-core attributes.

## Functional Requirements
This database will support:
* CRUD operations for users and clubs
* Tracking all clubs located in the given area, including contact details, price and facilities of all clubs
* Adding multiple comments to a club from users

Note that in this iteration, the system will not support users responding to comments from clubs.

## Representation

Entities are captured in SQLite tables with the following schema.

### Entities
The database includes the following entities:

#### Users

The `users` table includes:

* `id`, which specifies the unique ID for the user as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `first_name`, which specifies the user's first name as `TEXT`, given `TEXT` is appropriate for name fields.
* `last_name`, which specifies the user's last name. `TEXT` is used for the same reason as `first_name`.
* `phone_number`, which specifies the user's phone number as `TEXT`. A `UNIQUE` constraint ensures no two users have the same phone number.

All columns in the `users` table are required and hence should have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

#### Clubs

The `clubs` table includes:

* `id`, which specifies the unique ID for the club as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `club_name`, which specifies the club's name as `TEXT`, given `TEXT` is appropriate for name fields. A `UNIQUE` constraint ensures no two clubs have the same name.
* `accommodates`, which specifies the number of places in the club as `INTEGER`.
* `phone_number`, which specifies the club's phone number. A `UNIQUE` constraint ensures no two clubs have the same phone number.
* `club_description`, which specifies the description of the club as `TEXT`.

All columns in the `clubs` table are required and hence should have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not. No other constraints are necessary.

#### Availabilities

The `availabilities` table includes:

* `id`, which specifies the unique ID for the availability as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `club_id`, which is an `INTEGER` specifying the number of the club to which the availability is related. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `clubs` table to ensure data integrity.
* `date`, which specifies when the club is available. Prices in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>.
* `available`, which specifies whether the date is still available to be booked as `TEXT` (TRUE or FALSE).
* `price`, which specifies the cost of playing in the club. Floating point values in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>.

All columns in the `availabilities` table are required, and hence should have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not. No other constraints are necessary.

#### Addresses

The `addresses` table includes:

* `id`, which specifies the unique ID for the address of the club as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `club_id`, which is an `INTEGER` specifying the number of the club to which the address is related. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `clubs` table to ensure data integrity.
* `address`, which specifies the address of the club as `TEXT`.

All columns in the `addresses` table are required, and hence should have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not. No other constraints are necessary.

#### Payments

The `payments` table includes:

* `id`, which specifies the unique ID for the payment as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `user_id`, which is the ID of the user who made the payment as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integrity.
* `date`, which specifies when the payment was made. Dates in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>.
* `amount`, which specifies the amount of payment made. This column is represented with a `NUMERIC` type affinity, which can store either floats or integers.
* `card_details`, which is the information of the card used to make a payment as `INTEGER`. A `UNIQUE` constraint ensures no two users have the same card details.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

#### Reviews

The `reviews` table includes:

* `id`, which specifies the unique ID for the review as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `reviewer_id`, which specifies the ID of the user who wrote the comment as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table, which ensures that each comment be referenced back to a user.
* `club_id`, which specifies the ID of the club on which the comment was written as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `clubs` table, which ensures each comment belongs to a particular club.
* `date`, which specifies when the review was made. Dates in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>.
* `contents`, which contains the contents of the columns as `TEXT`, given that `TEXT` can still store long-form text.
* `rating`, which is the score, as an integer from 0 to 5, the user gave to the club as `INTEGER`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not. The `rating` column has an additional constraint to check if its value is greater than 0 and less than or equal 5, given that this is the valid range for a rating.

### Relationships
The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](diagram.jpg)

As detailed by the diagram:
* One user can play in one and only one club. At the same time, a club can accommodate 0 to many users: 0 if no users have yet visited the club, and many if more than one user has visited the club to play.
* An availability time is associated with one and only one club. At the same time, a club can have 0 to many available times: 0 if no slot is yet available, and many if more than one slot is available.
* An address is associated with one and only one club. At the same time, a club can have only 1 address which shows where the club is located in.
* A payment is associated with one and only one user. At the same time, a user can have 0 to many payments: 0 if no payment has yet made, and many if more than one payment has been made.
* A comment is associated with one and only one club, whereas a club can have 0 to many comments: 0 if a user has yet to comment on the club, and many if a user leaves more than one comment on a club.
* A comment is written by one and only one user. At the same time, a user can write 0 to many comments: 0 if they have yet to comment on any club, and many if they have written more than 1 comment.

## Optimizations
Per the typical queries in `queries.sql`, it is common for users of the database to access all club records by their names. For that reason, an index is created on the `club_name` column to speed the identification of clubs by name.

It is also common for users to access the club records located in a specific geographic area. For that reason, an index is created on the `address` column in the `addresses` table to speed the identification of clubs by address.

Similaryly, users might want to find clubs that meet their budget requirements. For that reason, an index is created on the `price` column in the `availabilities` table to speed the identification of clubs that match a specific price range.

Also, it is very common for users to find clubs that match their desired availability status. For that reason, an index is created on the `available` column in the `availabilities` table to speed the identification of clubs that are currently available or unavailable.

Similarly, it is also common practice for a user of the database to view all ratings provided to a particular club. As such, an index is created on the `rating` column in the `reviews` table to speed the identification of clubs by ranking.

## Limitations
The current schema assumes individual users. Collaborative payments would require a shift to a many-to-many relationship between users and payments.
