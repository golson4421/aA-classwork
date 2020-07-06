require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super("./db/questions.db")
        self.type_translation = true
        self.results_as_hash = true
    end
end

class ModelBase
    attr_accessor :id

    CLASS_LOOKUP = {
        User:           "users",
        Question:       "questions",
        QuestionFollow: "question_follows",
        Reply:          "replies",
        QuestionLike:   "question_likes"
    }

    def initialize(options_hash={})
        options_hash.each { |k,v| instance_variable_set("@#{k}", v) }
    end

    def save(options_hash={})
        if self.id.nil?
            columns = options_hash.keys.map(&:to_s).join(", ")
            values = options_hash.values.map { |val| val.is_a?(Integer) ? val : "'#{val}'" }.join(", ")
            sql = "INSERT INTO #{self.class.table_name} (#{columns}) VALUES (#{values})"
        else
            setter = []
            options_hash.each { |k,v| setter << "#{k} = #{v}"}
            setter = setter.join(", ")
            sql = "UPDATE #{self.class.table_name} SET #{setter} WHERE id = #{self.id}"
        end
        QuestionsDatabase.instance.execute(sql)
        @id ||= QuestionsDatabase.instance.last_insert_row_id
    end

    def self.all
        sql = "SELECT * FROM #{self.table_name}"
        self.find_by_query(sql)
    end

    def self.where(options)
        if options.is_a?(Hash)
            where_clause = options.map { |k, v| "#{k} = #{v.is_a?(Integer) ? v : "'#{v}'"}" }.join(" AND ")
        elsif options.is_a?(String)
            where_clause = options
        end
        sql = "SELECT * FROM #{self.table_name} WHERE #{where_clause}"
        self.find_by_query(sql)
    end

    def self.find_by(options_hash={})
        result = self.where(options_hash)
        raise "Too many records found, refine your search criteria" if result.is_a?(Array)
        result
    end

    def self.table_name
        CLASS_LOOKUP[self.to_s.to_sym]
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM #{self.table_name} WHERE id = #{id}"
        self.find_by_query(sql)
    end

    def self.find_by_query(sql)
        results = QuestionsDatabase.instance.execute(sql)
        return nil unless results.length > 0
        return self.new(results.first) if results.length == 1
        results.map! { |result| self.new(result)}
    end

end

require_relative "user"
require_relative "question"
require_relative "question_follow"
require_relative "reply"
require_relative "question_like"