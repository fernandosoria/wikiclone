class User < ActiveRecord::Base
  has_many :wikis
  has_and_belongs_to_many :wikicollaborators, class_name: 'Wiki'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  def role?(base_role)
    role == base_role.to_s
  end
end
