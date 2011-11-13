class Item < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :claimlist
  belongs_to :wantlist

  validates :title,     :presence => true

  def claimer=(user)
    raise "Must assign a user" unless user.is_a? User
    self.update_attribute(:claimlist_id, user.claimlist.id)
  end

  def owner=(user)
    raise "Must assign a user" unless user.is_a? User
    self.update_attribute(:wantlist_id, user.wantlist.id)
  end

  def claimer
    self.claimlist ? self.claimlist.user : nil
  end

  def owner
    self.wantlist ? self.wantlist.user : nil
  end

  def claimed?
    self.claimlist
  end

end
