
Specifications for the Rails Assessment - Music Enrollment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)

 :User has_many :enrollments

- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)

 :Enrollment belongs_to :instrument
 :Enrollment belongs_to :user

- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)

 :User has_many  :instruments, through::enrollments
 :Instrument has_many :users, through::enrollments

- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)

:Instrument has_many :enrollments

- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)

User can add , name of the Instrument, [:name] to the list

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
Enrollment model validations are :-
validates :level, :duration, presence: true
validates :instrument, presence: true
validates :price, numericality: {greater_than: 0, message: "$39, $49, $89 only !!"}
validates :student, presence: true, uniqueness: { case_sensitive: false }

User Model validations are:-
validates :username, presence: true, uniqueness: true
validates :email, presence: true, uniqueness: true

Instrument model vaidation is:-
validates :name, presence: true, uniqueness: true


- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

Instrument:- scope :alphabetize, -> { order(name: :asc) }
Enrollment:- scope :order_by_date, -> { order(created_at: :asc) }



- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
Omniauth - Google

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    http://127.0.0.1:3000/instruments/2/enrollments

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    http://127.0.0.1:3000/instruments/1/enrollments/new

- [x] Include form display of validation errors (form URL e.g. /recipes/new)
/instruments/new  - Name can't be blank
/enrollments/new - instrument, student, price, duration can't be blank


Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate

=================================================Sample Queries and helper methods======================================

# scope :created_before, ->(time) { where("created_at < ?", time) if time.present? }

    # scope :costs_more_than, ->(amount) { where("price > ?", amount) }
    
    
    # def self.created_before(time)
    #       where("created_at < ?", time) if time.present?
    #     end
    # end

    # def self.price_more_than(50)
    #     where("price > ?", 50)
    #   end
    # end


1) > Instrument.where(name:"Flute").count
   (0.9ms)  SELECT COUNT(*) FROM "instruments" WHERE "instruments"."name" = ?  [["name", "Flute"]]
 => 1 
2) >  Enrollment.where(student:"Erin Marshall").exists?
  Enrollment Exists? (0.3ms)  SELECT 1 AS one FROM "enrollments" WHERE "enrollments"."student" = ? LIMIT ?  [["student", "Erin Marshall"], ["LIMIT", 1]]
 => false 
3) > Enrollment.where(student:"Gloria Van").exists?
  Enrollment Exists? (0.3ms)  SELECT 1 AS one FROM "enrollments" WHERE "enrollments"."student" = ? LIMIT ?  [["student", "Gloria Van"], ["LIMIT", 1]]
 => true 
4) > Enrollment.where(student:"Gloria Van").any?
  Enrollment Exists? (0.3ms)  SELECT 1 AS one FROM "enrollments" WHERE "enrollments"."student" = ? LIMIT ?  [["student", "Gloria Van"], ["LIMIT", 1]]
 => true 
5) > Enrollment.where(student:"Gloria Van").many?
   (0.6ms)  SELECT COUNT(*) FROM "enrollments" WHERE "enrollments"."student" = ?  [["student", "Gloria Van"]]
 => false 
6) > Enrollment.where(created_at: true).many?
   (0.3ms)  SELECT COUNT(*) FROM "enrollments" WHERE "enrollments"."created_at" = ?  [["created_at", 1]]
 => false 
7) > Enrollment.where(created_at: true).any?
  Enrollment Exists? (0.7ms)  SELECT 1 AS one FROM "enrollments" WHERE "enrollments"."created_at" = ? LIMIT ?  [["created_at", 1], ["LIMIT", 1]]
 => false 
8) > Enrollment.where(level: "Beginner").any?
  Enrollment Exists? (0.3ms)  SELECT 1 AS one FROM "enrollments" WHERE "enrollments"."level" = ? LIMIT ?  [["level", "Beginner"], ["LIMIT", 1]]
 => true 
9) > Enrollment.where(level: "Beginner").many?
10) > Enrollment.all.sort_by{|enrollment| enrollment.price}
11) > Enrollment.all.sort_by{|enrollment| enrollment.price}.last
  Enrollment Load (0.5ms)  SELECT "enrollments".* FROM "enrollments"
 => #<Enrollment id: 6, startdate: "2021-07-04 00:00:00.000000000 +0000", student: "Joey Law", level: "Experienced", duration: 0, price: 89, user_id: 1, instrument_id: 2, created_at: "2021-02-21 16:51:35.185303000 +0000", updated_at: "2021-02-25 18:34:51.940772000 +0000"> 

12) > vocals = Instrument.find_or_create_by(name: "Vocals")
  Instrument Load (0.3ms)  SELECT "instruments".* FROM "instruments" WHERE "instruments"."name" = ? LIMIT ?  [["name", "Vocals"], ["LIMIT", 1]]
 => #<Instrument id: 7, name: "Vocals", created_at: "2021-02-24 00:43:37.771867000 +0000", updated_at: "2021-02-24 00:43:37.771867000 +0000"> 

13) > vocals.persisted?
 => true 

14) > vocals.new_record?
 => false 

15) >Instrument.pluck(:id, :name)
   (0.3ms)  SELECT "instruments"."id", "instruments"."name" FROM "instruments"
 => [[2, "Acoustic Guitar"], [3, "Violin"], [4, "Ukelele"], [6, "Flute"], [7, "Vocals"], [8, "Key Board"]] 

16) > Enrollment.pluck(:id, :level)
0.3ms)  SELECT "enrollments"."id", "enrollments"."level" FROM "enrollments"
 => [[3, "Experienced"], [6, "Experienced"], [7, "Intermediate"], [10, "Intermediate"], [11, "Intermediate"], [12, "Intermediate"], [16, "Intermediate"], [17, "Intermediate"], [18, "Beginner"], [26, "Intermediate"]] 

17) > Enrollment.pluck(:id, :student)
(0.3ms)  SELECT "enrollments"."id", "enrollments"."student" FROM "enrollments"
 => [[3, "Jake Marshall"], [6, "Joey Law"], [7, "Rose Blue"], [10, "Violet Gazera"], [11, "Margaret Phillip"], [12, "Emily Dickenson"], [16, "Raj Kaul"], [17, "Gloria Van"], [18, "Roman Law"], [26, "George Freddie"]] 
 
18) > Enrollment.pluck(:student)
   (0.6ms)  SELECT "enrollments"."student" FROM "enrollments"
 => ["Jake Marshall", "Joey Law", "Rose Blue", "Violet Gazera", "Margaret Phillip", "Emily Dickenson", "Raj Kaul", "Gloria Van", "Roman Law", "George Freddie"] 

19) > Enrollment.joins(:instrument,:user).pluck("enrollments.created_at,users.username,instruments.name")
   (0.6ms)  SELECT enrollments.created_at,users.username,instruments.name FROM "enrollments" INNER JOIN "instruments" ON "instruments"."id" = "enrollments"."instrument_id" INNER JOIN "users" ON "users"."id" = "enrollments"."user_id"
 => [[Sat, 20 Feb 2021 17:23:12.663043000 UTC +00:00, "Sunitee Mishra", "Violin"], [Sun, 21 Feb 2021 16:51:35.185303000 UTC +00:00, "Robert", "Acoustic Guitar"], [Mon, 22 Feb 2021 00:45:55.306703000 UTC +00:00, "Peter", "Acoustic Guitar"], [Mon, 22 Feb 2021 23:47:30.163803000 UTC +00:00, "Robert", "Flute"], [Tue, 23 Feb 2021 18:09:44.265466000 UTC +00:00, "Peter", "Acoustic Guitar"], [Wed, 24 Feb 2021 00:12:26.936083000 UTC +00:00, "Sunitee Mishra", "Acoustic Guitar"], [Wed, 24 Feb 2021 01:10:08.146980000 UTC +00:00, "Sunitee Mishra", "Acoustic Guitar"], [Wed, 24 Feb 2021 23:50:27.745334000 UTC +00:00, "Robert", "Key Board"], [Thu, 25 Feb 2021 18:30:12.365831000 UTC +00:00, "Robert", "Key Board"], [Thu, 25 Feb 2021 23:06:38.637947000 UTC +00:00, "Robert", "Ukelele"]] 


20) > Enrollment.ids
   (1.8ms)  SELECT "enrollments"."id" FROM "enrollments"
 => [6, 10, 17, 18, 26, 3, 12, 16, 7, 11]

 21) >Instrument.ids
   (0.6ms)  SELECT "instruments"."id" FROM "instruments"
 => [2, 3, 4, 6, 7, 8] 

 22) > Enrollment.where(level: "Intermediate").count
   (0.3ms)  SELECT COUNT(*) FROM "enrollments" WHERE "enrollments"."level" = ?  [["level", "Intermediate"]]
 => 7 
23) > Instrument.all=> i.last => 
  Instrument Load (0.4ms)  SELECT "instruments".* FROM "instruments" ORDER BY "instruments"."id" DESC LIMIT ?  [["LIMIT", 1]]
 => #<Instrument id: 8, name: "Key Board", created_at: "2021-02-24 01:07:34.726370000 +0000", updated_at: "2021-02-24 01:07:34.726370000 +0000"> 
2.6.1 :068 > i=_
 => #<Instrument id: 8, name: "Key Board", created_at: "2021-02-24 01:07:34.726370000 +0000", updated_at: "2021-02-24 01:07:34.726370000 +0000"> 
2.6.1 :069 > i.enrollments.count
   (0.7ms)  SELECT COUNT(*) FROM "enrollments" WHERE "enrollments"."instrument_id" = ?  [["instrument_id", 8]]
 => 2 

24) Enrollment.where("price > 50")
  Enrollment Load (0.4ms)  SELECT "enrollments".* FROM "enrollments" WHERE (price > 50) /* loading for inspect */ LIMIT ?  [["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<Enrollment id: 3, startdate: "2021-05-03 00:00:00.000000000 +0000", student: "Jake Marshall", level: "Experienced", duration: 4, price: 89, user_id: 2, instrument_id: 3, created_at: "2021-02-20 17:23:12.663043000 +0000", updated_at: "2021-02-22 15:34:44.705469000 +0000">, #<Enrollment id: 6, startdate: "2021-07-04 00:00:00.000000000 +0000", student: "Joey Law", level: "Experienced", duration: 0, price: 89, user_id: 1, instrument_id: 2, created_at: "2021-02-21 16:51:35.185303000 +0000", updated_at: "2021-02-25 18:34:51.940772000 +0000">]> 

 25)Enrollment.where("updated_at >= ?", Date.current.day)

 26)enrollments = Enrollment.includes(:instrument).limit(2)
  Enrollment Load (0.2ms)  SELECT "enrollments".* FROM "enrollments" /* loading for inspect */ LIMIT ?  [["LIMIT", 2]]
  Instrument Load (0.2ms)  SELECT "instruments".* FROM "instruments" WHERE "instruments"."id" IN (?, ?)  [[nil, 3], [nil, 2]]
 => #<ActiveRecord::Relation [#<Enrollment id: 3, startdate: "2021-05-03 00:00:00.000000000 +0000", student: "Jake Marshall", level: "Experienced", duration: 4, price: 89, user_id: 2, instrument_id: 3, created_at: "2021-02-20 17:23:12.663043000 +0000", updated_at: "2021-02-22 15:34:44.705469000 +0000">, #<Enrollment id: 6, startdate: "2021-07-04 00:00:00.000000000 +0000", student: "Joey Law", level: "Experienced", duration: 0, price: 89, user_id: 1, instrument_id: 2, created_at: "2021-02-21 16:51:35.185303000 +0000", updated_at: "2021-02-25 18:34:51.940772000 +0000">]> 

27) > Enrollment.select("created_at").group("created_at")