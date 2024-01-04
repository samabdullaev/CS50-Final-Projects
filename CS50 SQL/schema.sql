-- Represent users booking the club
CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represent clubs in the booking
CREATE TABLE "clubs" (
    "id" INTEGER,
    "club_name" TEXT NOT NULL UNIQUE,
    "accommodates" INTEGER NOT NULL,
    "phone_number" TEXT NOT NULL UNIQUE,
    "club_description" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent availabilities of clubs
CREATE TABLE "availabilities" (
    "id" INTEGER,
    "club_id" INTEGER,
    "date" NUMERIC NOT NULL,
    "available" TEXT NOT NULL,
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("id"),
);

-- Represent addresses of clubs
CREATE TABLE "addresses" (
    "id" INTEGER,
    "club_id" INTEGER,
    "address" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("id")
);

-- Represent payments made by users
CREATE TABLE "payments" (
    "id" INTEGER,
    "user_id" INTEGER,
    "date" NUMERIC NOT NULL,
    "amount" NUMERIC NOT NULL,
    "card_details" INTEGER NOT NULL UNIQUE,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represent individual reviews left by users
CREATE TABLE "reviews" (
    "id" INTEGER,
    "reviewer_id" INTEGER,
    "club_id" INTEGER,
    "date" NUMERIC NOT NULL,
    "contents" TEXT NOT NULL,
    "rating" INTEGER NOT NULL CHECK("rating" BETWEEN 0 AND 5),
    PRIMARY KEY("id"),
    FOREIGN KEY("reviewer_id") REFERENCES "users"("id")
    FOREIGN KEY("club_id") REFERENCES "clubs"("id")
);

-- Create indexes to speed common searches
CREATE INDEX "club_name_search" ON "clubs" ("club_name");
CREATE INDEX "club_address_search" ON "addresseses" ("address");
CREATE INDEX "club_price_search" ON "availabilities" ("price");
CREATE INDEX "club_availability_search" ON "availabilities" ("available");
CREATE INDEX "club_review_search" ON "reviews" ("rating");
