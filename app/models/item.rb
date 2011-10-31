class Item < ActiveRecord::Base
  belongs_to :claimlist
  belongs_to :wantlist

  def buyer=(user)
    raise "Must assign a user" unless user.is_a? User
    self.update_attribute(:claimlist_id, user.claimlist.id)
  end

  def owner=(user)
    raise "Must assign a user" unless user.is_a? User
    self.update_attribute(:wantlist_id, user.wantlist.id)
  end

  def buyer
    self.claimlist ? self.claimlist.user : nil
  end

  def owner
    self.wantlist ? self.wantlist.user : nil
  end

end
