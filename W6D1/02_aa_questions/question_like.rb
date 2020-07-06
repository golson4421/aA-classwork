require_relative "base"

class QuestionLike < ModelBase
    attr_accessor :liker_id, :question_id

    def self.likers_for_question_id(question_id)
        sql = "SELECT u.* FROM #{self.table_name} ql JOIN users u ON ql.liker_id = u.id"\
            " WHERE ql.question_id = #{question_id}"
        User.find_by_query(sql)
    end

    def self.num_likes_for_question_id(question_id)
        sql = "SELECT COUNT(DISTINCT liker_id) AS num_likes FROM #{self.table_name}"\
            " WHERE question_id = #{question_id}"
        query_result = QuestionsDatabase.instance.execute(sql).first
        query_result["num_likes"]
    end

    def self.liked_questions_for_user_id(user_id)
        sql = "SELECT q.* FROM #{self.table_name} ql JOIN questions q ON ql.question_id = q.id"\
            " WHERE ql.liker_id = #{user_id}"
        Question.find_by_query(sql)
    end

    def self.most_liked_questions(n)
        sub_query = "SELECT question_id, COUNT(liker_id) as num_likes FROM #{self.table_name}"\
            " GROUP BY 1 ORDER BY 2 DESC LIMIT #{n}"
        sql = "SELECT q.* FROM (#{sub_query}) mlq LEFT JOIN questions q ON mlq.question_id = q.id"\
            " ORDER BY mlq.num_likes DESC"
        result = Question.find_by_query(sql)
        result << nil until result.length == n
        result
    end

end