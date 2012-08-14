class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
   attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids
  # attr_accessible :title, :body
  
  # assign default role (:member)
  after_save :assign_role
  
  private
    def assign_role
      self.add_role :member
    end
end
