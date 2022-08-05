require_relative "./connection_adapter"

module ActiveRecord
  class Base
    #global variables
    @@connection = SqliteAdapter.new

    def initialize(attributes)
      @attributes = attributes
    end

    def method_missing(name, *args)
      p self.class
      if self.class.columns.include?(name)
        @attributes[name]
      else 
        super 
      end
    end

    def self.columns
      @@connection.columns(table_name)
    end

    def self.table_name
      self.name.downcase + "s" # => "users"
    end

    # find by id
    def self.find(id)
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
    end

    def self.create(values)
      #("INSERT into #{table}(#{columns}) values(#{values})")
    end

    def self.find_by_sql(sql)
      p sql
      rows = @@connection.execute(sql)
      p rows

      rows.map do |row|
        attributes = map_values_to_columns(row)  
        new(attributes)  # create attributes dynamically
      end

    end

    
    def self.map_values_to_columns(values)
      Hash[columns.zip(values)]
    end

  end
end



