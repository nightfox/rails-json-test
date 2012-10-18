class User
  include Mongoid::Document

  USERNUMBER = 1..30
  YEARS = 2004..2012

  field :name, type: String
  field :year_of_joining, type: Integer
  field :course, type: String
  field :branch, type: String
  field :location, type: String
  field :current_company, type: String

  def self.populate_data
    User.all.destroy
    for i in YEARS
      for j in USERNUMBER
        u = User.new({year_of_joining: i, })
        u.name = Faker::Name.name
        u.course = "B.Tech"
        u.branch = "Civil Engineering"
        u.location = Faker::Address.city
        u.current_company = Faker::Company.name
        u.save
      end
    end
  end
end
