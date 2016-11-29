class User < ActiveRecord::Base
  has_many :urls, dependent: :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
    # ej. User.authenticate('fernando@codea.mx', 'qwerty')

  @users = User.all

  def self.authenticate(email, password)
    if self.exists?(email: email)
    user = self.find_by(email: email)
    if password == user.password then user else nil
    # si el email y el password corresponden a un usuario valido, regresa el usuario
    # de otra manera regresa nil
   # end
    end
   end
  end
end