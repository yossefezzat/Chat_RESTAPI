class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy

  validates :number,
            presence: true,
            numericality: {only_integer: true},
            uniqueness: { scope: :application_id }

  def as_json(options={})
    super(options.merge({except: [:id, :application_id]}))
  end

end
