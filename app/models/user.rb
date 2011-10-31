class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :username, :password, :password_confirmation

  has_one :wantlist
  has_one :claimlist

  validates :name,      :presence     => true
  validates :username,  :presence     => true,
                        :length       => { :in => 2..32 },
                        :uniqueness   => { :case_sensitive => false }

  validates_presence_of :password, :on => :create
  validates_length_of   :password, :minimum => 8
end
