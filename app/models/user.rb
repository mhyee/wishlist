class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :username, :password, :password_confirmation

  before_create   :create_lists

  has_one :claimlist,   :dependent => :destroy
  has_one :wantlist,    :dependent => :destroy

  validates :name,      :presence     => true
  validates :username,  :presence     => true,
                        :length       => { :in => 2..32 },
                        :uniqueness   => { :case_sensitive => false }

  validates_presence_of :password, :on => :create
  validates_length_of   :password, :minimum => 8

  def claims
    self.claimlist.items
  end

  def wants
    self.wantlist.items
  end

protected

  def create_lists
    self.create_claimlist
    self.create_wantlist
  end

end
