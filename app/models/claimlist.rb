class Claimlist < List
  belongs_to :user
  has_many   :items
end
