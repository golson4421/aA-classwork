require_relative "base"

class User < ModelBase
    attr_accessor :fname, :lname

    def save
        options_hash = {"fname" => @fname, "lname" => @lname}
        super(options_hash)
    end

    def self.find_by_name(fname, lname)
        sql = "SELECT * FROM #{self.table_name} WHERE fname = #{fname} AND lname = #{lname}"
        self.find_by_query(sql)
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(self.id)
    end

    def average_karma
        sql = "SELECT COUNT(DISTINCT q.id) as num_questions, COUNT(ql.id) as num_likes"\
            " FROM questions q LEFT OUTER JOIN question_likes ql ON q.id = ql.question_id"\
            " WHERE q.user_id = #{self.id} GROUP BY q.user_id"
        query_result = QuestionsDatabase.instance.execute(sql).first
        num_questions, num_likes = query_result["num_questions"], query_result["num_likes"]
        num_likes / num_questions.to_f
    end

end