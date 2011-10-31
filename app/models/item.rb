class Item < ActiveRecord::Base
  belongs_to :wantlist
  belongs_to :claimlist
end
