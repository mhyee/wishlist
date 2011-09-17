class User < ActiveRecord::Base
  has_one     :wantlist
  has_one     :claimlist

  validates :name,      :presence   => true
  validates :username,  :presence   => true,
                        :length     => { :in => 2..32 },
                        :uniqueness => { :case_sensitive => false }
  validates :password,  :presence   => true,
                        :length     => { :minimum => 8 }
end
