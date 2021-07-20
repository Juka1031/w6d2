require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @col if @col != nil
    column = DBConnection.execute2(<<-SQL)
    Select *
    from #{self.table_name}
    SQL
    column = column.first
    @col = column.map do |val|
        val.parameterize.underscore.to_sym
    end
    
  end

  def attributes
    @attributes ||= {}

  end
  def self.finalize!
    self.columns.each do |val|
        define_method(val) do
            self.attributes << val
        end
        define_method("#{name}=") do |val|
        self.attributes[name] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    self.name.downcase + "s"
  end

  def self.all
    # ..
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

 

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
