require_relative "base"

class Reply < ModelBase
    attr_accessor :question_id, :parent_id, :user_id, :body

    def save
        options_hash = {"question_id" => @question_id, "parent_id" => @parent_id, "user_id" => @user_id, "body" => @body}
        super(options_hash)
    end

    def self.find_by_user_id(user_id)
        sql = "SELECT * FROM #{self.table_name} WHERE user_id = #{user_id}"
        self.find_by_query(sql)
    end

    def self.find_by_question_id(question_id)
        sql = "SELECT * FROM #{self.table_name} WHERE question_id = #{question_id}"
        self.find_by_query(sql)
    end

    def child_replies
        sql = "SELECT * FROM #{self.class.table_name} WHERE parent_id = #{self.id}"
        self.class.find_by_query(sql)
    end

    def author
        User.find_by_id(self.user_id)
    end

    def question
        Question.find_by_id(self.question_id)
    end

    def parent_reply
        return nil if self.parent_id.nil?
        Reply.find_by_id(self.parent_id)
    end

end