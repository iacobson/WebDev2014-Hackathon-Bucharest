class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :voters

  
  	#@fields = %w[Territory BEC]
  	#validates :field, :inclusion => @fields

  
end
