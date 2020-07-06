require_relative "base"

class Question < ModelBase
    attr_accessor :title, :body, :user_id

    def save
        options_hash = {"title" => @title, "body" => @body, "user_id" => @user_id}
        super(options_hash)
    end

    def self.find_by_author_id(author_id)
        sql = "SELECT * FROM #{self.table_name} WHERE user_id = #{author_id}"
        self.find_by_query(sql)
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def self.most_liked(n)
        QuestionFollow.most_liked_questions(n)
    end

    def author
        User.find_by_id(self.user_id)
    end

    def replies
        Reply.find_by_question_id(self.id)
    end

    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end


    def likers
        QuestionLike.likers_for_question_id(self.id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(self.id)
    end

end