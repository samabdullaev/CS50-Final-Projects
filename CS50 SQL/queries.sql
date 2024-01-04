-- Find all club records given club name
SELECT * FROM "clubs" WHERE "club_name" LIKE '%Chashma%';

-- Find all club records given club address
SELECT *
FROM "clubs"
JOIN "addresses" ON "clubs"."id" = "addresses"."club_id"
WHERE "addresses"."address" LIKE '%Chikryzov St%';

-- Find all club records given club price
SELECT *
FROM "clubs"
WHERE "id" IN (
    SELECT "club_id"
    FROM "availabilities"
    WHERE "price" = 4.50
);

-- Find all club records that has available slots to book
SELECT *
FROM "clubs"
WHERE "clubs"."id" IN (
    SELECT "club_id"
    FROM "availabilities"
    WHERE "available" = 'TRUE'
);

-- Find club ratings given club name
SELECT "rating"
FROM "reviews"
JOIN "clubs" ON "reviews"."club_id" = "clubs"."id"
WHERE "clubs"."club_name" LIKE '%Chashma%';

-- Add a new user
INSERT INTO "users" ("first_name", "last_name", "phone_number")
VALUES ('Samandar', 'Abdullaev', '998998011304');

-- Add a new club
INSERT INTO "clubs" ("club_name", "accommodates", "phone_number", "club_description")
VALUES ('Chashma', 20, '998901234567' ,'A very good game club with top-notch amenities and a friendly gaming community.');

-- Add a new availability
INSERT INTO "availabilities" ("id", "club_id", "date", "available", "price")
VALUES (1, 1, '2023-11-13', 'TRUE', 4.50);

-- Add a new review
INSERT INTO "reviews" ("reviewer_id", "club_id", "date", "contents", "rating")
VALUES (1, 1, '2023-10-22', 'Fantastic gaming experience with a friendly community', 5);
