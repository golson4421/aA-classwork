require "byebug"
require_relative 'db_connection'
require 'active_support/inflector'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
    attr_accessor :table_name, :attributes

    def self.columns
        sql = "SELECT * FROM #{self.table_name} LIMIT 1"
        @results ||= DBConnection.execute2(sql)
        @results.first.map(&:to_sym)
    end

    def self.finalize!
        self.columns.each do |col|
            define_method(col) { self.attributes[col] }
            define_method("#{col}=") { |val| self.attributes[col] = val }
        end
    end

    def self.table_name=(table_name)
        @table_name = table_name
    end

    def self.table_name
        @table_name || self.name.tableize
    end

    def self.all
        sql = "SELECT * FROM #{self.table_name}"
        results = DBConnection.execute(sql)
        results = self.parse_all(results)
    end

    def self.parse_all(results)
        return nil if results.length == 0
        results.map { |result| self.new(result) }
    end

    def self.find(id)
        sql = "SELECT * FROM #{self.table_name} WHERE id = #{id}"
        results = DBConnection.execute(sql)
        parsed = self.parse_all(results)
        parsed.first unless parsed.nil?
    end

    def initialize(params = {})
        params.each { |k,v| k = k.to_sym ; self.col_include?(k) ? self.setter(k, v) : (raise "unknown attribute '#{k}'") }
    end

    def setter(param, val)
        self.send("#{param}=", val)
    end

    def col_include?(param)
        self.class.columns.include?(param)
    end

    def attributes
        @attributes ||= {}
    end

    def attribute_values
        self.attributes.values.map { |val| val.is_a?(Integer) ? val : "#{val}" }
        # this doesn't return something in a useful form for SQL
    end

    def insert
        columns = self.attributes.keys.map(&:to_s).join(", ")
        values = self.attributes.values.map { |val| val.is_a?(Integer) ? val : "'#{val}'" }.join(", ")
        sql = "INSERT INTO #{self.class.table_name} (#{columns}) VALUES (#{values})"
        DBConnection.execute(sql)
        self.id ||= DBConnection.last_insert_row_id
    end

    def update
        setter = []
        self.attributes.each do |k,v|
            if v.is_a?(Integer)
                setter << "#{k} = #{v}"
            else
                setter << "#{k} = '#{v}'"
            end
        end
        setter = setter.join(", ")
        sql = "UPDATE #{self.class.table_name} SET #{setter} WHERE id = #{self.id}"
        DBConnection.execute(sql)
    end

    def save
        if self.id.nil?
            self.insert
        else
            self.update
        end
    end
end
