class Question < ActiveRecord::Base
  belongs_to :asker, class_name: "User"
  has_many :answers
  has_many :comments, as: :parent
  has_one :best_answer, class_name: "Answer"
  validates :title, presence: true
  validates :content, presence: true

  def order_answers
    ordered_answers = []
    answers = self.answers

    if self.best_answer
      ordered_answers << self.best_answer
      answers.delete(self.best_answer)

      answers.each do |answer|
        ordered_answers << answer
      end
    end
    ordered_answers

  end

  def self.all_by_date
    Question.all.order(created_at: :desc)
  end

  def date_posted
    self.created_at.strftime("%D %R %Z")
  end

end