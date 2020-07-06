require_relative "base"

class QuestionFollow < ModelBase
    attr_accessor :follower_id, :question_id

    def self.followers_for_question_id(question_id)
        sql = "SELECT u.* FROM users u JOIN question_follows qf ON u.id = qf.follower_id"\
            " WHERE qf.question_id = #{question_id}"
        [*User.find_by_query(sql)]
    end

    def self.followed_questions_for_user_id(user_id)
        sql = "SELECT q.* FROM question_follows qf JOIN questions q on qf.question_id = q.id"\
            " WHERE qf.follower_id = #{user_id}"
        [*Question.find_by_query(sql)]
    end

    def self.most_followed_questions(n)
        sql = "SELECT q.* FROM question_follows qf JOIN questions q on qf.question_id = q.id"\
            " GROUP BY 1 ORDER BY COUNT(qf.follower_id) DESC LIMIT #{n}"
        [*Question.find_by_query(sql)]
    end
    
end