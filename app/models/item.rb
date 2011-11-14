class Item < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :claimlist
  belongs_to :wantlist

  validates :title,     :presence => true

  def claimer=(user)
    if user.nil?
      self.update_attribute(:claimlist_id, nil)
    else
      raise "Must assign a user" unless user.is_a? User
      self.update_attribute(:claimlist_id, user.claimlist.id)
    end
  end

  def owner=(user)
    # Can't unset this
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
