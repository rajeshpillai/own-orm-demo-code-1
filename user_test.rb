require_relative "./application_record"
require_relative "./models/user"


def initialize_with_attributes 
  user = User.new(:id => 1, :name => "Rajesh")
  p user
end

def map_values_to_columns
  columns = [:id, :name]
  values = [1, "Rajesh"]

  expected_attributes = {:id => 1, :name => "Rajesh"}

  attributes = {}
  columns.each_with_index do |column, i|
    attributes[column] = values[i]
  end

  p attributes
end

initialize_with_attributes()
map_values_to_columns()

user = User.find(1)
p user
#first = User.all.first


# user = User.new(:id => 1, :name => "Rajesh")

# p user.name

