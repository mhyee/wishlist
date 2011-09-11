class User < ActiveRecord::Base
  has_one     :wantlist
  has_one     :claimlist
end
