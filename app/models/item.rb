class Item < ActiveRecord::Base
  belongs_to :claimlist
  belongs_to :wantlist
end
