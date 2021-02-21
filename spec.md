
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


- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
Instrument:- scope :alphabetize, -> { order(name: :asc) }
Enrollment:- scope :ordered_by_date, -> { order(created_at: :asc) }


- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
Omniauth - Google

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    http://127.0.0.1:3000/instruments/2/enrollments to see only acoustic guitar shoes

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
users/1/enrollments/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
/instruments/new  - Name can't be blank
/enrollments/new - instrument,student, price, duration can't be blank
Confirm:
- [ ] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate