class Restaurant < ActiveRecord::Base

  belongs_to :user

  has_many :reviews, dependent: :destroy

  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true



  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end
